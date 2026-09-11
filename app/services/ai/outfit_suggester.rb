module Ai
  class OutfitSuggester
    MODEL = "claude-sonnet-5"
    # Wall-clock budget for one suggestion. Larger than the tagger's because
    # this call reads the whole wardrobe and writes up to 1024 tokens, and it
    # runs in a job rather than in the request. Budget = timeout * (1 + max_retries).
    # /!\ These MUST travel with the request. A timeout passed to
    # Anthropic::Client is silently overwritten by the SDK
    # (anthropic-1.67.0, resources/messages.rb:81-91).
    REQUEST_OPTIONS = { timeout: 45, max_retries: 1 }.freeze
    MAX_CONTEXT = 300 # cap free-text length (light prompt injection guard)
    SHOES = "Shoes".freeze
    # Shoes never leave the wardrobe between regenerations: they are the
    # scarcest category in most wardrobes, so banning a pair after a single
    # proposal exhausts the outfit space long before the tops and bottoms
    # have been explored.
    # /!\ This rule is tied to the parent category NAME seeded in
    # db/seeds.rb. Renaming "Shoes" there switches it off silently - no test
    # would fail, the exclusion list would simply start eating shoes again.
    TOPS = "Tops".freeze
    # Swimwear sits on the same body zone as a bottom: a swimsuit still needs
    # a top and a pair of shoes, exactly like a pair of shorts would.
    BOTTOMS = %w[Bottoms Swimwear].freeze
    # A single full-body piece dresses both halves on its own.
    FULL_BODY = %w[Dresses Suits].freeze

    Result = Data.define(:rationale, :garment_ids, :name)

    class Error < StandardError; end
    class TooFewGarments < Error; end
    class NoValidGarments < Error; end
    class DuplicateOutfit < Error; end
    class NoAlternative < Error; end

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

      Each wardrobe line reads:
      [id] name — subcategory, parent category, colour, formality, season, pattern, brand — user tags: ...
      Machine attributes are reliable; user tags are free-form and may be noisy.

      Layer map (torso pieces), used by the rules below:
      - base: tshirt, long sleeves, polo, shirt, tank top
      - mid: hoodie, sweatshirt, knitwear, cardigan
      - outer: coat, jacket, blazer, parka

      Hard rules, no exceptions:
      - Choose pieces ONLY from the wardrobe list you are given.
      - Reference every piece by its numeric id.
      - If anchor pieces are named, they MUST appear in your outfit.
      - Every outfit MUST include a pair of shoes, AND must cover the body: either
        a Top plus a Bottom (Swimwear counts as a Bottom), or a single full-body
        piece ( a Dress or a Suit). Never propose an outfit with no shoes.
      - Never put two pieces on the same slot: same body zone (the parent category)
        AND same layer. Stacking base + mid + outer on the torso is encouraged;
        at most one piece for the bottom and one pair of shoes.
      - A full-body piece (a Dress or a Suit) is both top and bottom: do not add a
        separate Top or Bottom to it.

      You do not know live fashion trends past your training cutoff — rely on timeless
      styling fundamentals, not on "current" trends.
    PROMPT

    def initialize(user:, context:, anchor_garment_ids: [], exclude_garment_ids: [], weather: nil, client: nil)
      @user = user
      @context = context.to_s.strip.first(MAX_CONTEXT)
      @anchor_garment_ids = Array(anchor_garment_ids).map(&:to_i)
      @exclude_garment_ids = Array(exclude_garment_ids).map(&:to_i)
      @weather = weather
      @client = client || Anthropic::Client.new(api_key: Rails.application.credentials.dig(:anthropic, :api_key))
    end

    def suggest
      unless composable?(available_garments)
        raise TooFewGarments unless composable?(@user.garments)
        raise NoAlternative
      end
      message = @client.messages.create(
        model: MODEL,
        max_tokens: 1024,
        thinking: { type: "disabled" }, # Sonnet 5 thinks by default, we force one tool call, no thinking
        system_: SYSTEM,
        tools: [ TOOL ],
        tool_choice: { type: "tool", name: "propose_outfit" },
        messages: [ { role: "user", content: user_message } ],
        request_options: REQUEST_OPTIONS
      )
      proposal = tool_input(message)
      validated_ids = without_excluded(owned_ids(proposal["garment_ids"]))
      raise NoValidGarments if validated_ids.empty?
      raise DuplicateOutfit if duplicate?(validated_ids)
      Result.new(
        rationale: proposal["rationale"],
        garment_ids: validated_ids,
        name: proposal["name"]
      )
    end

    private

    def composable?(scope)
      parents = parent_names(scope)
      parents.include?(SHOES) &&
        (parents.intersect?(FULL_BODY) ||
          (parents.include?(TOPS) && parents.intersect?(BOTTOMS)))
    end

    def parent_names(scope)
      Category.where(id: scope.select(:category_id))
              .includes(:parent)
              .filter_map { |leaf| leaf.parent&.name }
              .uniq
    end

    def tool_input(message)
      block = message.content.find { |b| b.type.to_s == "tool_use" }
      raise Error, "no tool_use block in response" unless block
      block.input.with_indifferent_access
    end

    def owned_ids(returned_ids)
      ids = Array(returned_ids).map(&:to_i)
      @user.garments.where(id: ids).ids
    end

    def without_excluded(ids)
      offenders = ids & excluded_ids
      if offenders.any?
        Rails.logger.warn("[OutfitSuggester] user=#{@user.id} model returned excluded ids #{offenders}")
      end
      ids - excluded_ids
    end

    def excluded_ids
      @excluded_ids ||= @exclude_garment_ids - reusable_excluded_ids
    end

    def reusable_excluded_ids
      return [] if @exclude_garment_ids.empty?
      shoes = Category.find_by(name: SHOES)
      return [] unless shoes
      @user.garments.where(id: @exclude_garment_ids, category: shoes.subcategories).ids
    end

    def available_garments
      @user.garments.where.not(id: excluded_ids)
    end

    def garments
      @garments ||= available_garments.includes(:tags, category: :parent).to_a
    end

    def inventory
      garments.map do |g|
        machine = [ g.category.name, g.category.parent&.name, g.color,
                   g.formality, g.season, g.pattern, g.brand ].compact_blank
        tags = g.tags.map(&:name).join(", ")
        line = "[#{g.id}] #{g.name} — #{machine.join(", ")}"
        line += " — user tags: #{tags}" unless tags.empty?
        line
      end.join("\n")
    end

    def user_message
      lines = [ "Wardrobe:", inventory, "", "Context: #{@context}" ]
      lines << @weather if @weather
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
      outfit_ids_map[outfit.id] || []
    end

    # "Already present" = the EXACT same set of garment ids (order-agnostic)
    # A shared piece is fine; only an identical combination counts as a duplicate.
    def duplicate?(garment_ids)
      target = garment_ids.sort
      existing_outfits.any? { |o| outfit_ids(o).sort == target }
    end

    def outfit_ids_map
      @outfit_ids_map ||= OutfitGarment
        .where(outfit_id: existing_outfits.map(&:id))
        .pluck(:outfit_id, :garment_id)
        .group_by(&:first)
        .transform_values { |pairs| pairs.map(&:last) }
    end
  end
end
