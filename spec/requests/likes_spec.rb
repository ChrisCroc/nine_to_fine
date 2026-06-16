require "rails_helper"

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:outfit) { create(:outfit, user: user) }

  context "when not signed in" do
    it "redirects to the login page" do
      post outfit_likes_path(outfit)

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when signed in" do
    before { sign_in user }

    describe "POST /outfits/:outfit_id/likes" do
      it "creates the like and redirects to the outfit" do
        expect {
          post outfit_likes_path(outfit)
        }.to change(Like, :count).by(1)

        expect(response).to redirect_to(outfit_path(outfit))
      end

      it "is idempotent when the outfit is already liked" do
        create(:like, user: user, likeable: outfit)

        expect {
          post outfit_likes_path(outfit)
        }.not_to change(Like, :count)
      end

      it "allows liking another user's outfit (social v1)" do
        other_outfit = create(:outfit, user: other_user)

        expect {
          post outfit_likes_path(other_outfit)
        }.to change(Like, :count).by(1)

        expect(response).to redirect_to(outfit_path(other_outfit))
      end
    end

    describe "DELETE /outfits/:outfit_id/likes/:id" do
      it "destroys the user's own like and redirect to the outfit" do
        like = create(:like, user: user, likeable: outfit)

        expect {
            delete outfit_like_path(outfit, like)
        }.to change(Like, :count).by(-1)

        expect(response).to redirect_to(outfit_path(outfit))
      end
    end
  end

  context "when signed in as another user (IDOR sentinel)" do
    let(:like_of_other) { create(:like, user: other_user) }

    before { sign_in user }

    it "returns 404 when trying to destroy another user's like" do
      like_of_other

      expect {
        delete outfit_like_path(like_of_other.likeable, like_of_other)
    }.not_to change(Like, :count)

      expect(response).to have_http_status(:not_found)
    end
  end
end
