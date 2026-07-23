require "rails_helper"

RSpec.describe "Publications", type: :request do
  let(:owner) { create(:user) }
  let(:stranger) { create(:user) }
  let(:outfit) { create(:outfit, user: owner, visibility: :private) }

  it "publishes the owner's outfit" do
    sign_in owner
    post outfit_publication_path(outfit)

    expect(outfit.reload.visibility_public?).to be true
  end

  it "unpublishes the owner's outfit" do
    outfit.visibility_public!
    sign_in owner
    delete outfit_publication_path(outfit)

    expect(outfit.reload.visibility_private?).to be true
  end

  it "returns 404 when a stranger tries to publish (IDOR sentinel)" do
    sign_in stranger
    post outfit_publication_path(outfit)

    expect(response).to have_http_status(:not_found)
    expect(outfit.reload.visibility_private?).to be true
  end
end
