require "rails_helper"

RSpec.describe "Suggestions", type: :request do
  let(:user) { create(:user) }

  describe "POST /suggestions" do
    context "when signed in with a context" do
      before { sign_in user }

      it "enqueues the suggestion job and answers with turbo_streams" do
        expect {
          post suggestions_path, params: { context: "interview, 13°C" },
                                            headers: { "Accept" => "text/vnd.turbo-stream.html" }
        }.to have_enqueued_job(OutfitSuggestionJob)
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
        expect(response.body).to include('<turbo-stream action="update"')
        expect(response.body).to include('target="ai_suggestion_modal"')
      end

      it "does not enqueued when context and anchors are both blank" do
        expect {
          post suggestions_path, params: { context: "" },
                                            headers: { "Accept" => "text/vnd.turbo-stream.html" }
        }.not_to have_enqueued_job(OutfitSuggestionJob)
      end
    end

    context "when not signed in" do
      it "redirects to the login page" do
        post suggestions_path, params: { context: "x" }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
