module Ai
  class OutfitSuggester
    MODEL = "claude-sonnet-5"
    MIN_GARMENTS = 3
    MAX_CONTENT = 300 # cap free-text length (light prompt injection guard)

    Result = Data.define(:rationale, :garment_ids, :name)

    class Error < StandardError; end
    class TooFewGarments < Error; end
    class NoValidGarments < Error; end
    class DuplicateOutfit < Error; end

    TOOL = {
      name: "propose_outfit",
      description: "Return the outfit you propose, chosen ONLY from the provided wardrobe. Reference each piece by its numeric id.",
      input_schema: {
        type: "object",
        properties: {
          garment_ids: {
            type: "array",
            items: { type: "integer" },
            description: "Ids of the wardrobe pieces that make up the outfit. Only ids present in the inventory."
          },
          name: { type: "string", description: "A short, evocative name for the outfit (~40 chars max)." },
          rationale: { type: "string", description: "One short paragraph on why these pieces work for the context." }
        },
        required: %w[garment_ids name rationale]
      }
    }.freeze

    SYSTEM = <<~PROMPT.freeze
      You are a personal stylist. You build coherent outfits using colour theory,
      proportion, and occasion-appropriateness.

      Hard rules, no exceptions:
      - Choose pieces ONLY from the wardrobe list you are given.
      - Reference every piece by its numeric id.
      - If anchor pieces are named, they MUST appear in your outfit.
      You do not know live fashion trends past your training cutoff — rely on timeless
      styling fundamentals, not on "current" trends.
    PROMPT

    def initialize(user:, context:, anchor_garment_ids: [], client: nil)
      @user = user
      @context = context.to_s.strip.first(MAX_CONTENT)
      @anchor_garment_ids = Array(anchor_garment_ids).map(&:to_i)
      @client = client || Anthropic::Client.new(api_key: Rails.application.credentials.dig(:anthropic, :api_key))
    end

    def suggest
      raise TooFewGarments if @user.garments.size < MIN_GARMENTS
      message = @client.messages.create(
        model: MODEL,
        max_tokens: 1024,
        thinking: { type: "disabled" }, # Sonnet 5 thinks by default, we force one tool call, no thinking
        system_: SYSTEM,
        tools: [ TOOL ],
        tool_choice: { type: "tool", name: "propose_outfit" },
        messages: [ { role: "user", content: user_message } ]
      )
      proposal = tool_input(message)
      validated_ids = valid_ids(proposal["garment_ids"])
      raise NoValidGarments if validated_ids.empty?
      raise DuplicateOutfit if duplicate?(validated_ids)
      Result.new(
        rationale: proposal["rationale"],
        garment_ids: validated_ids,
        name: proposal["name"]
      )
    end

    private

    def tool_input(message)
      block = message.content.find { |b| b.type.to_s == "tool_use" }
      raise Error, "no tool_use block in response" unless block
      block.input.with_indifferent_access
    end

    def valid_ids(returned)
      ids = Array(returned).map(&:to_i)
      @user.garments.where(id: ids).ids
    end

    def garments
      @garments ||= @user.garments.includes(:category, :tags).to_a
    end

    def inventory
      garments.map do |g|
        tags = g.tags.map(&:name).join(", ")
        "[#{g.id}] #{g.name} - #{g.color}, #{g.category.name}, #{g.brand}, tags: #{tags}"
      end.join("\n")
    end

    def user_message
      lines = [ "Wardrobe:", inventory, "", "Context: #{@context}" ]
      unless existing_outfits.empty?
        lines << ""
        lines << "Outfits already owned - do NOT re-propose any of these EXACT combinations:"
        existing_outfits.each { |o| lines << "- #{o.name}: [#{outfit_ids(o).join(', ')}]" }
      end
      lines.join("\n")
    end

    def existing_outfits
      @existing_outfits ||= @user.outfits.to_a
    end

    def outfit_ids(outfit)
      outfit.outfit_garments.map(&:garment_id)
    end

    # "Already present" = the EXACT same set of garment ids (order-agnostic)
    # A shared piece is fine; only an identical combination counts as a duplicate.
    def duplicate?(ids)
      target = ids.sort
      existing_outfits.any? { |o| outfit_ids(o).sort == target }
    end
  end
end
