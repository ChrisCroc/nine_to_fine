require "rails_helper"

RSpec.describe "Garments", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:category) { create(:category) }
  let(:garment) { create(:garment, user: user, category: category) }

  context "when not signed in" do
    it "redirects to the login page" do
      get garments_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when signed in as the owner" do
    before { sign_in user }

    describe "GET /garments" do
      context "without filters" do
        it "returns a successful response" do
          garment
          get garments_path
          expect(response).to have_http_status(:success)
        end
      end

      context "with filters" do
        it "returns a successful response (integration smoke test)" do
          garment
          get garments_path, params: { q: { color: garment.color, category_id: category.id } }
          expect(response).to have_http_status(:success)
        end
      end
    end

    describe "GET /garments/:id" do
      it "returns a successful response" do
        get garment_path(garment)
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET /garments/new" do
      it "returns a successful response" do
        get new_garment_path
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST /garments" do
      context "with valid params" do
        let(:valid_params) do
          { garment: { name: "Veste bleue", color: "blue", category_id: category.id } }
        end

        it "creates the garment, redirects to its show, and sets the flash" do
          expect {
            post garments_path, params: valid_params
          }.to change(Garment, :count).by(1)

          expect(response).to redirect_to(garment_path(Garment.last))
          expect(flash[:notice]).to match(/created/i)
        end
      end

      context "with invalid params" do
        let(:invalid_params) do
          { garment: { name: "", color: "blue", category_id: category.id } }
        end

        it "does not create the garment and re-renders :new with 422" do
          expect {
            post garments_path, params: invalid_params
          }.not_to change(Garment, :count)

          expect(response).to have_http_status(:unprocessable_content)
        end
      end
    end

    describe "GET /garments/:id/edit" do
      it "returns a successful response" do
        get edit_garment_path(garment)
        expect(response).to have_http_status(:success)
      end
    end

    describe "PATCH /garments/:id" do
      context "with valid params" do
        it "updates the garment, redirects to its show, and sets the flash" do
          patch garment_path(garment), params: { garment: { name: "Renamed" } }

          expect(response).to redirect_to(garment_path(garment))
          expect(flash[:notice]).to match(/updated/i)
          expect(garment.reload.name).to eq("Renamed")
        end
      end

      context "with invalid params" do
        it "does not update the garment and re-renders :edit with 422" do
          original_name = garment.name
          patch garment_path(garment), params: { garment: { name: "" } }

          expect(response).to have_http_status(:unprocessable_content)
          expect(garment.reload.name).to eq(original_name)
        end
      end
    end

    describe "DELETE /garments/:id" do
      it "destroys the garment, redirects to index, and sets the flash" do
        garment
        expect {
          delete garment_path(garment)
        }.to change(Garment, :count).by(-1)

        expect(response).to redirect_to(garments_path)
        expect(flash[:notice]).to match(/deleted/i)
      end
    end
  end

  context "when signed in as another user (IDOR sentinels)" do
    let(:other_garment) { create(:garment, user: other_user, category: category) }

    before { sign_in user }

    it "returns 404 when trying to show another user's garment" do
      get garment_path(other_garment)
      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when trying to edit another user's garment" do
      get edit_garment_path(other_garment)
      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when trying to update another user's garment" do
      patch garment_path(other_garment), params: { garment: { name: "Hacked" } }
      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when trying to destroy another user's garment" do
      delete garment_path(other_garment)
      expect(response).to have_http_status(:not_found)
    end
  end
end
