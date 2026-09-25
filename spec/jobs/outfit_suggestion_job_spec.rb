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

  it "broadcasts a non-retryable error for TooFewGarments" do
    allow_any_instance_of(Ai::OutfitSuggester).to receive(:suggest)
      .and_raise(Ai::OutfitSuggester::TooFewGarments)

    expect(Turbo::StreamsChannel).to receive(:broadcast_replace_to)
      .with(user, :outfit_suggestions, hash_including(locals: hash_including(retryable: false, context: "x")))

      described_class.perform_now(user: user, context: "x")
  end

  it "broadcasts a non-retryable error for NoAlternative" do
    allow_any_instance_of(Ai::OutfitSuggester).to receive(:suggest)
      .and_raise(Ai::OutfitSuggester::NoAlternative)

    expect(Turbo::StreamsChannel).to receive(:broadcast_replace_to)
      .with(user, :outfit_suggestions, hash_including(locals: hash_including(retryable: false)))

    described_class.perform_now(user: user, context: "x")
  end

  it "broadcasts a retryable error for DuplicateOutfit" do
    allow_any_instance_of(Ai::OutfitSuggester).to receive(:suggest)
      .and_raise(Ai::OutfitSuggester::DuplicateOutfit)

    expect(Turbo::StreamsChannel).to receive(:broadcast_replace_to)
      .with(user, :outfit_suggestions, hash_including(locals: hash_including(retryable: true)))

    described_class.perform_now(user: user, context: "x")
  end

  it "passes the excluded ids through to the suggester" do
    suggester = instance_double(Ai::OutfitSuggester, suggest: result)
    allow(Ai::OutfitSuggester).to receive(:new).and_return(suggester)
    allow(Turbo::StreamsChannel).to receive(:broadcast_replace_to)

    described_class.perform_now(user: user, context: "x", exclude_garment_ids: [ 7, 9 ])

    expect(Ai::OutfitSuggester).to have_received(:new).with(
      user: user, context: "x", anchor_garment_ids: [], exclude_garment_ids: [ 7, 9 ],
      weather: nil
    )
  end

  it "passes the context to the result partial" do
    allow_any_instance_of(Ai::OutfitSuggester).to receive(:suggest).and_return(result)

    expect(Turbo::StreamsChannel).to receive(:broadcast_replace_to)
      .with(user, :outfit_suggestions, hash_including(locals: hash_including(context: "rainy interview")))

    described_class.perform_now(user: user, context: "rainy interview")
  end


  it "accumulates the proposed pieces into the exclusion list of the result partial" do
    allow_any_instance_of(Ai::OutfitSuggester).to receive(:suggest).and_return(result)

    expect(Turbo::StreamsChannel).to receive(:broadcast_replace_to)
      .with(user, :outfit_suggestions,
            hash_including(locals: hash_including(exclude_garment_ids: [ 5, 1, 2 ])))

    described_class.perform_now(user: user, context: "x", exclude_garment_ids: [ 5 ])
  end

  # The list arrives from the form as strings and grows with integers from the
  # proposal, so "1" and 1 are two different entries for uniq. The witness here
  # is a piece present on both sides: without the to_i it survives twice.
  it "keeps one entry per piece in the accumulated exclusion list" do
    allow_any_instance_of(Ai::OutfitSuggester).to receive(:suggest).and_return(result)

    expect(Turbo::StreamsChannel).to receive(:broadcast_replace_to)
      .with(user, :outfit_suggestions,
            hash_including(locals: hash_including(exclude_garment_ids: [ 1, 2 ])))

    described_class.perform_now(user: user, context: "x", exclude_garment_ids: %w[1])
  end

  it "passes the anchors through to the suggester" do
    suggester = instance_double(Ai::OutfitSuggester, suggest: result)
    allow(Ai::OutfitSuggester).to receive(:new).and_return(suggester)
    allow(Turbo::StreamsChannel).to receive(:broadcast_replace_to)

    described_class.perform_now(user: user, context: "", anchor_garment_ids: %w[4])

    expect(Ai::OutfitSuggester).to have_received(:new).with(
      user: user, context: "", anchor_garment_ids: %w[4], exclude_garment_ids: [],
      weather: nil
    )
  end

  # Every other example sends no position, so the weather service stops at its
  # first line: this is the only one that walks from the browser's position to
  # the stylist's prompt.
  it "hands the weather at the user's position to the suggester" do
    weather = instance_double(Weather::OpenMeteo, sentence: "Current weather at the user's location: 14.2°C.")
    allow(Weather::OpenMeteo).to receive(:new).with([ 48.86, 2.35 ]).and_return(weather)
    suggester = instance_double(Ai::OutfitSuggester, suggest: result)
    allow(Ai::OutfitSuggester).to receive(:new).and_return(suggester)
    allow(Turbo::StreamsChannel).to receive(:broadcast_replace_to)

    described_class.perform_now(user: user, context: "x", coordinates: [ 48.86, 2.35 ])

    expect(Ai::OutfitSuggester).to have_received(:new)
      .with(hash_including(weather: "Current weather at the user's location: 14.2°C."))
  end

  it "sends the anchors back to the result partial" do
    allow_any_instance_of(Ai::OutfitSuggester).to receive(:suggest).and_return(result)

    expect(Turbo::StreamsChannel).to receive(:broadcast_replace_to)
      .with(user, :outfit_suggestions,
            hash_including(locals: hash_including(anchor_garment_ids: %w[4])))

    described_class.perform_now(user: user, context: "x", anchor_garment_ids: %w[4])
  end

  # The error path is the one nobody walks while testing by hand: without this,
  # a failed suggestion drops the anchors and the retry silently ignores them.
  it "sends the anchors back to the error partial too" do
    allow_any_instance_of(Ai::OutfitSuggester).to receive(:suggest)
      .and_raise(Ai::OutfitSuggester::NoValidGarments)

    expect(Turbo::StreamsChannel).to receive(:broadcast_replace_to)
      .with(user, :outfit_suggestions,
            hash_including(locals: hash_including(anchor_garment_ids: %w[4])))

    described_class.perform_now(user: user, context: "x", anchor_garment_ids: %w[4])
  end

  it "broadcasts a retryable error for AnchorMissing" do
    allow_any_instance_of(Ai::OutfitSuggester).to receive(:suggest)
      .and_raise(Ai::OutfitSuggester::AnchorMissing)

    expect(Turbo::StreamsChannel).to receive(:broadcast_replace_to)
      .with(user, :outfit_suggestions, hash_including(locals: hash_including(retryable: true)))

    described_class.perform_now(user: user, context: "x")
  end

  # Without its own branch in friendly_message, AnchorMissing falls into the
  # generic else and tells the user something went wrong reaching the stylist -
  # which is false: the stylist answered, and the answer was refused.
  it "explains an AnchorMissing failure in terms of the pieces the user picked" do
    allow_any_instance_of(Ai::OutfitSuggester).to receive(:suggest)
      .and_raise(Ai::OutfitSuggester::AnchorMissing)

    expect(Turbo::StreamsChannel).to receive(:broadcast_replace_to)
      .with(user, :outfit_suggestions,
            hash_including(locals: hash_including(message: a_string_matching(/pieces you picked/))))

    described_class.perform_now(user: user, context: "x")
  end
end
