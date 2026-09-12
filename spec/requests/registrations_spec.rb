require "rails_helper"

RSpec.describe "Account deletion", type: :request do
  let(:user) { create(:user, password: "password123") }

  describe "GET /users/delete" do
    it "renders the confirmation screen when signed in" do
      sign_in user

      get confirm_destroy_user_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("This cannot be undone")
    end

    it "redirects an anonymous visitor to the sign-in page" do
      get confirm_destroy_user_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "DELETE /users" do
    before { sign_in user }

    it "destroys the account when the password is correct" do
      expect {
        delete user_registration_path, params: { user: { current_password: "password123" } }
      }.to change(User, :count).by(-1)
    end

    it "refuses and keeps the account when the password is wrong" do
      expect {
        delete user_registration_path, params: { user: { current_password: "not-the-password" } }
      }.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_content)
      expect(response.body).to include("That password is incorrect")
    end

    it "refuses and keeps the account when no password is given" do
      expect {
        delete user_registration_path
      }.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_content)
      expect(response.body).to include("Enter your password to confirm")
    end
  end
end
