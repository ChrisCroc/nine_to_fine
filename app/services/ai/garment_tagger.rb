require "base64"

module Ai
  class GarmentTagger
    MODEL = "claude-sonnet-5"
    TOOL_NAME = "record_garment"
    # Wall-clock budget for one analysis, spent INSIDE the request
    # (see garments/analyses_controller.rb): it holds a Puma thread - one of
    # three - until it returns. The SDK defaults to 600 s per attempt and
    # retries twice, so a silent connection would freeze that thread for half
    # an hour. Budget = timeout * (1 + max_retries).
    # /!\ These MUST travel with the request. A timeout passed to
    # Anthropic::Client is silently overwritten by the SDK
    # (anthropic-1.67.0, resources/messages.rb:81-91).
    REQUEST_OPTIONS = { timeout: 20, max_retries: 1 }.freeze

    CLAUDE_MEDIA_TYPES = %w[image/jpeg image/png image/gif image/webp].freeze

    Result = Data.define(:color, :category_id, :name, :formality, :season, :pattern)

    class Error < StandardError; end

    SYSTEM = <<~PROMPT.freeze
      You are a fashion cataloguer. Look at the single garment in the photo and
      describe ONLY what is visibly true of it. Never guess or invent.

      Call the record_garment tool exactly once. For every field, choose a value
      ONLY from that field's allowed list. If the photo does not let you decide a
      field with confidence, OMIT that field entirely rather than guessing.

      - color: the single dominant colour of the piece.
      - category: the most specific garment type from the allowed list.
      - name: a short plain descriptive name, e.g. "White linen shirt" (~40 chars).
      - formality / season / pattern: describe the piece objectively.
    PROMPT

    def initialize(photo:, client: nil)
      @photo = photo
      @client = client || Anthropic::Client.new(api_key: Rails.application.credentials.dig(:anthropic, :api_key))
    end

    def tag
      message = @client.messages.create(
        model: MODEL,
        max_tokens: 512,
        thinking: { type: "disabled" },
        system_: SYSTEM,
        tools: [ tool ],
        tool_choice: { type: "tool", name: TOOL_NAME },
        messages: [ { role: "user", content: content } ],
        request_options: REQUEST_OPTIONS
      )
      build_result(tool_input(message))
    end

    private

    def tool
      {
        name: TOOL_NAME,
        description: <<~DESC,
          Record the attributes of the single garment shown in the photo.
          Omit any field if you cannot determine with confidence.
        DESC
        input_schema: {
          type: "object",
          properties: {
            color: {
              type: "string", enum: Garment::COLORS, description: "The dominant colour."
            },
            category: {
              type: "string", enum: Category.leaves.pluck(:name), description: "The most specific garment type"
            },
            name: {
              type: "string", description: "Short descriptive name (~40 chars)"
            },
            formality: {
              type: "string", enum: Garment.formalities.keys, description: "How dressed-up the piece is"
            },
            season: {
              type: "string", enum: Garment.seasons.keys, description: "The season it best suits"
            },
            pattern: {
              type: "string", enum: Garment.patterns.keys, description: "Its visual pattern"
            }
          },
          required: []
        }
      }
    end

    def content
      bytes, media_type = read_image
      [
        { type: "image", source: { type: "base64", media_type: media_type, data: Base64.strict_encode64(bytes) } },
        { type: "text", text: "Catalogue the single garment shown in this photo." }
      ]
    end

    def read_image
      media_type = @photo.content_type
      raise Error, "unsupported image type: #{media_type}" unless
        CLAUDE_MEDIA_TYPES.include?(media_type)

      bytes = @photo.respond_to?(:download) ? @photo.download : @photo.read
      [ bytes, media_type ]
    end

    def tool_input(message)
      block = message.content.find { |b| b.type.to_s == "tool_use" }
      raise Error, "no tool_use block in response" unless block
      block.input.with_indifferent_access
    end

    def build_result(input)
      Result.new(
        color: whitelisted(input[:color], Garment::COLORS),
        category_id: leaf_id(input[:category]),
        name: input[:name].presence,
        formality: whitelisted(input[:formality], Garment.formalities.keys),
        season: whitelisted(input[:season], Garment.seasons.keys),
        pattern: whitelisted(input[:pattern], Garment.patterns.keys),
      )
    end

    def whitelisted(value, allowed)
      allowed.include?(value) ? value : nil
    end

    def leaf_id(name)
      return nil if name.blank?
      Category.leaves.find_by(name: name)&.id
    end
  end
end
