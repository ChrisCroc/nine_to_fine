require "rails_helper"

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:outfit) { create(:outfit, user: user) }

  context "when not signed in" do
    it "redirects to the login page" do
      post outfit_comments_path(outfit), params: { comment: { body: "Nice" } }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when signed in" do
    before { sign_in user }

    describe "POST /outfits/:outfit_id/comments" do
      it "creates the commment and redirects to the outfit" do
        expect {
          post outfit_comments_path(outfit), params: { comment: { body: "Love this outfit" } }
        }.to change(Comment, :count).by(1)

        expect(response).to redirect_to(outfit_path(outfit))
      end

      it "does not create a comment with a blank body" do
        expect {
          post outfit_comments_path(outfit), params: { comment: { body: "" } }, as: :turbo_stream
        }.not_to change(Comment, :count)

        expect(response).to have_http_status(:unprocessable_content)
      end

      it "allows commenting another user's outfit (social V1)" do
        other_outfit = create(:outfit, user: other_user)

        expect {
          post outfit_comments_path(other_outfit), params: { comment: { body: "Cool" } }
        }.to change(Comment, :count).by(1)
      end
    end

    describe "DELETE /outfits/:outfit_id/comments/:id" do
      it "destroys the user's own comment and redirects" do
        comment = create(:comment, user: user, outfit: outfit)

        expect {
          delete outfit_comment_path(outfit, comment)
        }.to change(Comment, :count).by(-1)

        expect(response).to redirect_to(outfit_path(outfit))
      end
    end
  end

  context "when signed in as another user (IDOR sentinel)" do
    let(:comment_of_other) { create(:comment, user: other_user) }

    before { sign_in user }

    it "returns 404 when trying to destroy another user's comment" do
      comment_of_other

      expect {
        delete outfit_comment_path(comment_of_other.outfit, comment_of_other)
      }.not_to change(Comment, :count)

      expect(response).to have_http_status(:not_found)
    end
  end
end
