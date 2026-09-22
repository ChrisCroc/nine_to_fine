require "rails_helper"

RSpec.describe "Explore", type: :request do
  context "when not signed in" do
    it "redirects to the login page" do
      get explore_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when signed in" do
    let(:viewer) { create(:user) }
    let(:author) { create(:user) }

    before { sign_in viewer }

    describe "GET /explore" do
      it "shows the public outfits of other members" do
        create(:outfit, user: author, visibility: :public, name: "VisibleLook")

        get explore_path

        expect(response.body).to include("VisibleLook")
      end

      it "never shows a private outfit" do
        create(:outfit, user: author, visibility: :public, name: "ShownLook")
        create(:outfit, user: author, visibility: :private, name: "HiddenLook")

        get explore_path

        expect(response.body).to include("ShownLook")
        expect(response.body).not_to include("HiddenLook")
      end

      it "renders only the first batch of twelve" do
        create(:outfit, user: author, visibility: :public, name: "OldestLook", created_at: 30.days.ago)
        11.times { |i| create(:outfit, user: author, visibility: :public, created_at: (i + 1).hours.ago) }
        create(:outfit, user: author, visibility: :public, name: "NewestLook", created_at: 1.minute.ago)

        get explore_path

        expect(response.body).to include("NewestLook")
        expect(response.body).not_to include("OldestLook")
      end

      it "names the author of each outfit and links to their profile" do
        create(:outfit, user: author, visibility: :public, name: "VisibleLook")

        get explore_path

        expect(response.body).to include(author.username)
        expect(response.body).to include(user_path(author))
      end
    end

    describe "GET /explore?page=2" do
      it "renders the second batch without the outfits of the first" do
        create(:outfit, user: author, visibility: :public, name: "OldestLook", created_at: 30.days.ago)
        12.times { |i| create(:outfit, user: author, visibility: :public, name: "Recent#{i}", created_at: (i + 1).hours.ago) }

        get explore_path(page: 2), headers: { "Accept" => "text/vnd.turbo-stream.html" }

        expect(response.body).to include("OldestLook")
        expect(response.body).not_to include("Recent0")
      end

      it "answers with a Turbo Stream that appends to the grid" do
        13.times { |i| create(:outfit, user: author, visibility: :public) }

        get explore_path(page: 2), headers: { "Accept" => "text/vnd.turbo-stream.html" }

        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
        expect(response.body).to include('<turbo-stream action="append"')
        expect(response.body).to include('target="explore_outfits"')
      end
    end
  end
end
