require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "GET /users/:id" do
    context "when signed in" do
      before { sign_in user }

      it "renders the profile" do
        get user_path(user)

        expect(response).to have_http_status(:ok)
      end
    end

    context "when not signed in" do
      it "redirects to the login page" do
        get user_path(user)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
