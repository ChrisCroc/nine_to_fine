module Ai
  class OutfitSuggester
    MODEL = "claude-sonnet-5"
    MIN_GARMENTS = 3

    Result = Data.define(:rationale, :garment_ids, :name)

    class Error < StandardError; end
    class TooFewGarments < Error; end
    class NoValidGarments < Error; end

    def initialize(user:, context:, anchor_garment_ids: [], client: nil)
      @user = user
      @context = context
      @anchor_garment_ids = anchor_garment_ids
      @client = client
    end

    def suggest
      raise TooFewGarments if @user.garments.size < MIN_GARMENTS
      message = @client.messages.create(
        model: MODEL,
        max_tokens: 1024,
        messages: [ { role: "user", content: user_message } ]
      )
      proposal = tool_input(message)
      validated_ids = valid_ids(proposal["garment_ids"])
      raise NoValidGarments if validated_ids.empty?
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
      block.input
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
  end
end
