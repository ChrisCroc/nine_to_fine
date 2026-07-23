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
      it "is viewable by an anonymous visitor" do
        get user_path(user)

        expect(response).to have_http_status(:ok)
        expect(response.body).to include(user.username)
      end

      it "lists the owner's public outfits, never the private ones" do
        create(:outfit, user: user, name: "PublicLook", visibility: :public)
        create(:outfit, user: user, name: "SecretLook", visibility: :private)

        get user_path(user)

        expect(response.body).to include("PublicLook")
        expect(response.body).not_to include("SecretLook")
      end
    end
  end

  describe "GET /users/:id/edit" do
    before { sign_in user }

    it "renders the edit form for own profile" do
      get edit_user_path(user)

      expect(response).to have_http_status(:ok)
    end

    it "redirects when editing another user's profile (IDOR sentinel)" do
      other = create(:user)

      get edit_user_path(other)

      expect(response).to redirect_to(user_path(other))
    end
  end

  describe "PATCH /users/:id" do
    before { sign_in user }

    it "updates own username" do
      patch user_path(user), params: { user: { username: "newname" } }

      expect(user.reload.username).to eq("newname")
      expect(response).to redirect_to(user_path(user))
    end

    it "re-renders on invalid username" do
      patch user_path(user), params: { user: { username: "ab" } }

      expect(response).to have_http_status(:unprocessable_content)
      expect(user.reload.username).not_to eq("ab")
    end

    it "does not update another user's profile (IDOR sentinel)" do
      other = create(:user)

      patch user_path(other), params: { user: { username: "hacked" } }

      expect(other.reload.username).not_to eq("hacked")
    end
  end
end
