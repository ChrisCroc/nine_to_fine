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
    end

    context "when the user is signed in" do
      let(:user) { create(:user) }
      before { sign_in user }

      it "returns a successful response" do
        get root_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end
