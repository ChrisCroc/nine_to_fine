require "rails_helper"

RSpec.describe "The Explore feed", type: :system do
  let(:user) { create(:user) }
  let(:author) { create(:user) }

  before do
    # One look more than a batch of 12, the newest first: "Look 13" is the only
    # one left for the second batch.
    13.times do |n|
      create(:outfit, user: author, name: "Look #{n + 1}", visibility: :public, created_at: n.minutes.ago)
    end
    sign_in user
  end

  it "adds the next batch under the first one, without leaving the page" do
    visit explore_path

    expect(page).to have_css("#explore_outfits > div", count: 12)
    expect(page).to have_no_css("#explore_outfits h2", exact_text: "Look 13")

    click_link "Load more"

    # A full page load of page 2 would show one card; an append keeps all 13.
    expect(page).to have_css("#explore_outfits > div", count: 13)
    expect(page).to have_css("#explore_outfits h2", exact_text: "Look 1")
    expect(page).to have_css("#explore_outfits h2", exact_text: "Look 13")
    expect(page).to have_no_link("Load more")
  end
end
