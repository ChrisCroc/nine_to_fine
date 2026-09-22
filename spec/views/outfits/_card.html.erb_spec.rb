require "rails_helper"

# The card is shared by three pages: the Explore feed, the owner's Looks page
# and a public profile. Only the feed names the author. Testing that through a
# rendered page is unreliable: the navbar already carries user_path(current_user)
# on every signed-in page (navigation_helper.rb:6).
# /!\ type: :view is explicit: infer_spec_type_from_file_location! is off.

RSpec.describe "outfits/_card", type: :view do
  let(:author) { create(:user, username: "margaux") }
  let(:outfit) { create(:outfit, user: author, name: "SummerLook") }

  it "names the author and links to their profile when asked to" do
    render partial: "outfits/card", locals: { outfit: outfit, show_author: true }

    expect(Capybara.string(rendered)).to have_link("margaux", href: user_path(author))
  end

  it "stays silent about the author by default" do
    render partial: "outfits/card", locals: { outfit: outfit }

    expect(rendered).not_to include("margaux")
  end
end
