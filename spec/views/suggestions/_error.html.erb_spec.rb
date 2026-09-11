require "rails_helper"

# Same reasoning as the result partial: nothing else renders this file.
# /!\ type: :view is explicit: infer_spec_type_from_file_location! is off.
RSpec.describe "suggestions/_error", type: :view do
  def render_with(coordinates, retryable: true)
    render partial: "suggestions/error",
           locals: { message: "The stylist could not answer", retryable: retryable,
                     context: "wedding", exclude_garment_ids: [], coordinates: coordinates }
  end

  it "sends the position back with the Regenerate button" do
    render_with([ 50.85, 4.35 ])

    form = Capybara.string(rendered)
    expect(form).to have_css("input[name='latitude'][value='50.85']", visible: :all)
    expect(form).to have_css("input[name='longitude'][value='4.35']", visible: :all)
  end

  it "still renders its Regenerate button when there is no position" do
    expect { render_with(nil) }.not_to raise_error
    expect(rendered).to include("Regenerate")
  end

  # The retryable flag was silently stuck on false for three days in September:
  # both halves of a boolean need a witness.
  it "omits the button entirely when the error cannot be replayed" do
    render_with([ 50.85, 4.35 ], retryable: false)

    expect(rendered).to include("The stylist could not answer")
    expect(rendered).not_to include("Regenerate")
  end
end
