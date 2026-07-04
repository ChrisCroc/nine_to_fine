require "rails_helper"

RSpec.describe OutfitSuggestionJob do
  let(:user) { create(:user) }
  let(:result) { Ai::OutfitSuggester::Result.new(rationale: "R", garment_ids: [ 1, 2 ], name: "N") }

  it "broadcasts the result to the user's suggestion stream" do
    allow_any_instance_of(Ai::OutfitSuggester).to receive(:suggest).and_return(result)

    expect(Turbo::StreamsChannel).to receive(:broadcast_replace_to)
      .with(user, :outfit_suggestions, hash_including(target: "ai_suggestion", partial: "suggestions/result"))

    described_class.perform_now(user: user, context: "x")
  end

  it "broadcasts a graceful error partial when the service fails" do
    allow_any_instance_of(Ai::OutfitSuggester).to receive(:suggest)
      .and_raise(Ai::OutfitSuggester::NoValidGarments)

    expect(Turbo::StreamsChannel).to receive(:broadcast_replace_to)
      .with(user, :outfit_suggestions, hash_including(target: "ai_suggestion", partial: "suggestions/error"))

    described_class.perform_now(user: user, context: "x")
  end
end
