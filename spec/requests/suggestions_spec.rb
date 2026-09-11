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

      it "passes the excluded ids to the job" do
        expect {
          post suggestions_path, params: { context: "wedding", exclude_garment_ids: %w[31 58] },
                                 headers: { "Accept" => "text/vnd.turbo-stream.html" }
        }.to have_enqueued_job(OutfitSuggestionJob).with(
          user: user, context: "wedding", anchor_garment_ids: [], exclude_garment_ids: %w[31 58],
          coordinates: nil
        )
      end

      it "refuses a blank context, enqueues nothing, and answers inside the modal" do
        expect {
          post suggestions_path, params: { context: "   " },
                                  headers: { "Accept" => "text/vnd.turbo-stream.html" }
        }.not_to have_enqueued_job(OutfitSuggestionJob)

        expect(response).to have_http_status(:unprocessable_content)
        expect(response.body).to include('<turbo-stream action="update"')
        expect(response.body).to include('target="ai_suggestion_modal"')
        expect(response.body).to include("Tell the stylist about the occasion")
      end

      it "enqueues when anchors are given without a context" do
        expect {
          post suggestions_path, params: { anchor_garment_ids: %w[7] },
                                  headers: { "Accept" => "text/vnd.turbo-stream.html" }
        }.to have_enqueued_job(OutfitSuggestionJob).with(
          user: user, context: nil, anchor_garment_ids: %w[7], exclude_garment_ids: [],
          coordinates: nil
        )
      end

      it "hands the job a usable position as a single pair" do
        expect {
          post suggestions_path,
                params: { context: "interview", latitude: "50.8503396", longitude: "4.3517103" },
                headers: { "Accept" => "text/vnd.turbo-stream.html" }
        }.to have_enqueued_job(OutfitSuggestionJob).with(
          user: user, context: "interview", anchor_garment_ids: [], exclude_garment_ids: [],
          coordinates: [ 50.8503396, 4.3517103 ]
        )
      end

      # to_f would answer 0.0 here, and 0.0/0.0 is a real spot in the Gulf of
      # Guinea the weather API answers for. Asserting nil is asserting that.
      it "drops a position it cannot read" do
        expect {
          post suggestions_path,
                params: { context: "interview", latitude: "abc", longitude: "4.35" },
                headers: { "Accept" => "text/vnd.turbo-stream.html" }
        }.to have_enqueued_job(OutfitSuggestionJob).with(
          user: user, context: "interview", anchor_garment_ids: [], exclude_garment_ids: [],
          coordinates: nil
        )
      end

      it "drops a position that is a number but not a place" do
        expect {
          post suggestions_path,
                params: { context: "interview", latitude: "91", longitude: "4.35" },
                headers: { "Accept" => "text/vnd.turbo-stream.html" }
        }.to have_enqueued_job(OutfitSuggestionJob).with(
          user: user, context: "interview", anchor_garment_ids: [], exclude_garment_ids: [],
          coordinates: nil
        )
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
