require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET /" do
    context "when a user is not signed in" do
      before { get root_path }

      it "returns a successful response (home is public)" do
        expect(response).to have_http_status(:success)
      end

      it "renders a real text <h1> for SEO" do
        expect(response.body).to include("<h1")
      end

      it "renders the three blocks as <h2> headings" do
        expect(response.body.scan("<h2").size).to be >=3
      end

      it "renders the marketing footer with contact links" do
        expect(response.body).to include("Christophe Crokaert")
        expect(response.body).to include("mailto:croc1014@me.com")
        expect(response.body).to include("github.com/ChrisCroc")
        expect(response.body).to include("linkedin.com/in/christophe-crokaert")
      end

      it "shows three real public outfits" do
        author = create(:user)
        4.times do |i|
          create(:outfit,
                  user: author,
                  visibility: :public,
                  name: "Look #{i}",
                  created_at: i.hours.ago)
        end

        get root_path

        expect(response.body).to include("Look 0", "Look 1", "Look 2")
        expect(response.body).not_to include("Look 3")
      end

      it "never shows a private outfit" do
        author = create(:user)
        create(:outfit, user: author, visibility: :private, name: "Hidden look")

        get root_path

        expect(response.body).not_to include("Hidden look")
      end
    end

    context "when the user is signed in" do
      let(:user) { create(:user) }
      before { sign_in user }

      it "returns a successful response" do
        get root_path
        expect(response).to have_http_status(:success)
      end

      it "serves the Explore feed at the root" do
        author = create(:user)
        create(:outfit, user: author, visibility: :public, name: "VisibleLook")

        get root_path

        expect(response.body).to include("VisibleLook")
      end
    end
  end
end
