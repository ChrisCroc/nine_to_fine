class OutfitSuggestionJob < ApplicationJob
  queue_as :default

  NON_RETRYABLE = [
    Ai::OutfitSuggester::TooFewGarments,
    Ai::OutfitSuggester::NoAlternative
].freeze

  def perform(user:, context:, anchor_garment_ids: [], exclude_garment_ids: [])
    result = Ai::OutfitSuggester.new(
      user: user,
      context: context,
      anchor_garment_ids: anchor_garment_ids,
      exclude_garment_ids: exclude_garment_ids
    ).suggest

    Turbo::StreamsChannel.broadcast_replace_to(
      user, :outfit_suggestions,
      target: "ai_suggestion",
      partial: "suggestions/result",
      locals: { result: result, context: context,
                exclude_garment_ids: exclude_garment_ids + result.garment_ids }
    )
  rescue => e
    Rails.logger.error("[OutfitSuggestionJob] #{e.class}: #{e.message}")
    Turbo::StreamsChannel.broadcast_replace_to(
      user, :outfit_suggestions,
      target: "ai_suggestion",
      partial: "suggestions/error",
      locals: { message: friendly_message(e),
                retryable: NON_RETRYABLE.none? { |klass| e.is_a?(klass) },
                context: context,
                exclude_garment_ids: exclude_garment_ids }
    )
  end

  private

  def friendly_message(error)
    case error
    when Ai::OutfitSuggester::TooFewGarments
      "Add a few more garments first - the stylist needs a pair of shoes, plus a top and a
        bottom, or a dress."
    when Ai::OutfitSuggester::NoValidGarments
      "The stylist couldn't build an outfit this time. Try rephrasing your context."
    when Ai::OutfitSuggester::DuplicateOutfit
      "You already have this exact outfit. Regenerate or change the context."
    when Ai::OutfitSuggester::NoAlternative
      "You've been through most of your wardrobe for this context. Start over or add more garments."
    else
      "Something went wrong reaching the stylist. Please try again."
    end
  end
end
