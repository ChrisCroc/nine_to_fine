class OutfitSuggestionJob < ApplicationJob
  queue_as :default

  def perform(user:, context:, anchor_garment_ids: [])
    result = Ai::OutfitSuggester.new(
      user: user, context: context, anchor_garment_ids: anchor_garment_ids
    ).suggest

    Turbo::StreamsChannel.broadcast_replace_to(
      user, :outfit_suggestions,
      target: "ai_suggestion",
      partial: "suggestions/result",
      locals: { result: result }
    )
  rescue => e
    Rails.logger.error("[OutfitSuggestionJob] #{e.class}: #{e.message}")
    Turbo::StreamsChannel.broadcast_replace_to(
      user, :outfit_suggestions,
      target: "ai_suggestion",
      partial: "suggestions/error",
      locals: { message: friendly_message(e) }
    )
  end

  private

  def friendly_message(error)
    case error
    when Ai::OutfitSuggester::TooFewGarments
      "Add a few more garments first - the stylist needs at least 3 pieces to work with."
    when Ai::OutfitSuggester::NoValidGarments
      "The stylist couldn't build an outfit this time. Try rephrasing your context."
    when Ai::OutfitSuggester::DuplicateOutfit
      "You already have this exact outfit. Regenerate or change the context."
    else
      "Something went wrong reaching the stylist. Please try again."
    end
  end
end
