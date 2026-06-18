require "rails_helper"

RSpec.describe "Follows", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  context "when not signed in" do
    it "redirects to th elogin page" do
      post user_follow_path(other_user)

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when signed in" do
    before { sign_in user }

    describe "POST /users/:user_id/follow" do
      it "creates the follow and redirects to the profile" do
        expect {
          post user_follow_path(other_user)
        }.to change(Follow, :count).by(1)

        expect(response).to redirect_to(user_path(other_user))
      end

      it "is idempotent when already following" do
        create(:follow, follower: user, followed: other_user)

        expect {
          post user_follow_path(other_user)
      }.not_to change(Follow, :count)
      end
    end

    describe "DELETE /users/:user_id/follow" do
      it "destroys the user's own follow and redirects to the profile" do
        create(:follow, follower: user, followed: other_user)

        expect {
          delete user_follow_path(other_user)
        }.to change(Follow, :count).by(-1)

        expect(response).to redirect_to(user_path(other_user))
      end
    end
  end

  context "when signed in as another user (scoping sentinel)" do
    let(:third_user) { create(:user) }

    before { sign_in user }

    it "does not destroy a follow it does not own (no-op, not 404)" do
      create(:follow, follower: other_user, followed: third_user)

      expect {
        delete user_follow_path(third_user)
      }.not_to change(Follow, :count)

      expect(response).to redirect_to(user_path(third_user))
    end
  end
end
