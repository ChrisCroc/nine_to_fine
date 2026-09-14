require "rails_helper"

# The only place that actually RENDERS this partial. The job specs stub
# broadcast_replace_to, so a typo in a local name would reach production.
# /!\ type: :view is explicit: infer_spec_type_from_file_location! is off.
RSpec.describe "suggestions/_result", type: :view do
  let(:result) { Ai::OutfitSuggester::Result.new(rationale: "R", garment_ids: [], name: "N") }

  def render_with(coordinates, anchor_garment_ids: [])
    render partial: "suggestions/result",
           locals: { result: result, context: "wedding",
                     anchor_garment_ids: anchor_garment_ids,
                     exclude_garment_ids: [], coordinates: coordinates }
  end

  # Regenerate is a form of its own: what it does not carry is lost. Drop the
  # anchors here and the second proposal quietly ignores what was asked for.
  it "sends the anchored pieces back with the Regenerate button" do
    render_with([ 50.85, 4.35 ], anchor_garment_ids: %w[52 7])

    form = Capybara.string(rendered)
    expect(form).to have_css("input[name='anchor_garment_ids[]'][value='52']", visible: :all)
    expect(form).to have_css("input[name='anchor_garment_ids[]'][value='7']", visible: :all)
  end

  it "sends the position back with the Regenerate button" do
    render_with([ 50.85, 4.35 ])

    form = Capybara.string(rendered)
    expect(form).to have_css("input[name='latitude'][value='50.85']", visible: :all)
    expect(form).to have_css("input[name='longitude'][value='4.35']", visible: :all)
  end

  # A refused geolocation must not take the modal down. This partial is rendered
  # inside the job: an exception here costs the suggestion AND the error partial
  # meant to replace it, leaving the spinner turning forever.
  it "still renders its Regenerate button when there is no position" do
    expect { render_with(nil) }.not_to raise_error
    expect(rendered).to include("Regenerate")
  end
end
