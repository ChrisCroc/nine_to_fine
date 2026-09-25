require "rails_helper"

RSpec.describe "Signing in", type: :system do
  # The regression of PR #229: after a sign-in, Turbo follows the redirect to
  # "/" still asking for a Turbo Stream. When the feed answered with one, the
  # page never changed - no error, the form simply looked like it had not been
  # sent. Every request spec stayed green, since none of them follows a
  # redirect in a browser.
  it "lands on the Explore feed" do
    create(:user, email: "chris@example.com", password: "password123")
    create(:outfit, name: "Windy summer", visibility: :public)

    visit new_user_session_path
    fill_in "Email", with: "chris@example.com"
    fill_in "Password", with: "password123"
    click_button "Log in"

    expect(page).to have_css("h1", text: "Explore")
    expect(page).to have_css("h2", exact_text: "Windy summer")
  end
end
