require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET /" do
    context "when a user is not signed in" do
      it "returns a successful response (home is public)" do
        get root_path
        expect(response).to have_http_status(:success)
      end
    end

    context "when the user is signed in"
      let(:user) { create(:user) }
      before { sign_in user }

      it "returns a successful response" do
        get root_path
        expect(response).to have_http_status(:success)
      end
  end
end
