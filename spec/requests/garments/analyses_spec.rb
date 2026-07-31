require "rails_helper"

RSpec.describe "Garments::Analyses", type: :request do
  let(:user) { create(:user) }
  let(:photo) { fixture_file_upload("valid.jpg", "image/jpeg") }

  def stub_tagger(result)
    tagger = instance_double(Ai::GarmentTagger, tag: result)
    allow(Ai::GarmentTagger).to receive(:new).and_return(tagger)
  end

  it "redirects an anonymous request to login" do
    post garments_analyses_path, params: { photo: photo }

    expect(response).to redirect_to(new_user_session_path)
  end

  it "returns the analysis as JSON for a signed_in user" do
    sign_in user
    stub_tagger(Ai::GarmentTagger::Result.new(
      color: "white", category_id: 42, name: "white shirt",
      formality: "smart_casual", season: "summer", pattern: "solid"
    ))

    post garments_analyses_path, params: { photo: photo }

    expect(response).to have_http_status(:ok)
    body = response.parsed_body
    expect(body["color"]).to eq("white")
    expect(body["category_id"]).to eq(42)
    expect(body["formality"]).to eq("smart_casual")
  end

  it "returns a 422 when the service fails" do
    sign_in user
    allow(Ai::GarmentTagger).to receive(:new).and_raise(Ai::GarmentTagger::Error)

    post garments_analyses_path, params: { photo: photo }

    expect(response).to have_http_status(:unprocessable_content)
    expect(response.parsed_body["error"]).to eq("analysis_failed")
  end
end
