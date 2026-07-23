require "rails_helper"

RSpec.describe "Outfits", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:garment) { create(:garment, user: user) }
  let(:outfit) { create(:outfit, user: user) }

  context "when not signed in" do
    it "redirects to the login page" do
      get outfits_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when signed in as the owner" do
    before { sign_in user }

    describe "GET /outfits" do
      it "retruns a successful response" do
        outfit
        get outfits_path
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET /outfits with filters" do
      let(:summer) { create(:tag, name: "summer", user: user) }
      let(:chic) { create(:tag, name: "chic", user: user) }

      it "keeps only outfits having all requested tags" do
        both = create(:outfit, user: user, name: "SummerChicFit")
        one = create(:outfit, user: user, name: "SummerOnlyFit")
        create(:tagging, tag: summer, taggable: both)
        create(:tagging, tag: chic, taggable: both)
        create(:tagging, tag: summer, taggable: one)

        get outfits_path(q: { tag_ids: [ summer.id, chic.id ] })

        expect(response.body).to include("SummerChicFit")
        expect(response.body).not_to include("SummerOnlyFit")
      end

      it "filters by contained garment via q[garment_id]" do
        piece = create(:garment, user: user, name: "White shirt")
        with_piece = create(:outfit, user: user, name: "ShirtFit")
        without = create(:outfit, user: user, name: "OtherFit")
        with_piece.garments << piece

        get outfits_path(q: { garment_id: piece.id })

        expect(response.body).to include("ShirtFit")
        expect(response.body).not_to include("OtherFit")
      end

      it "does not leak another user's outfit when passing a foreign garment_id (IDOR sentinel)" do
        stranger_piece = create(:garment)
        stranger_outfit = create(:outfit, user: stranger_piece.user, name: "StrangerFit")
        stranger_outfit.garments << stranger_piece

        get outfits_path(q: { garment_id: stranger_piece.id })

        expect(response.body).not_to include("StrangerFit")
      end
    end

    describe "GET /outfits/:id" do
      it "returns a successful response" do
        get outfit_path(outfit)
        expect(response).to have_http_status(:success)
      end

      it "doesn't trigger any N+1 when loading the comments's authors" do
        create(:comment, outfit: outfit, user: create(:user))
        create(:comment, outfit: outfit, user: create(:user))

        get outfit_path(outfit)

        expect(response).to have_http_status(:success)
      end
    end

    describe "GET /outfits/new" do
      it "returns a successful response" do
        get new_outfit_path
        expect(response).to have_http_status(:success)
      end

      it "pre-selects the user's own garments and the name" do
        mine = create_list(:garment, 2, user: user)
        get new_outfit_path(garment_ids: mine.map(&:id), name: "AI pick")

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("AI pick")
        mine.each do |garment|
          expect(response.body).to include("selected=\"selected\" value=\"#{garment.id}\"")
        end
      end
    end

    describe "POST /outfits" do
      context "with valid params" do
        let(:valid_params) do
          { outfit: { name: "Look casual", garment_ids: [ garment.id ] } }
        end

        it "creates the outfit, redirects to its show, and sets the flash" do
          expect {
            post outfits_path, params: valid_params
        }.to change(Outfit, :count).by(1)

        expect(response).to redirect_to(outfit_path(Outfit.last))
        expect(flash[:notice]).to match(/created/i)
        end
      end

      context "with invalid params" do
        let(:invalid_params) do
          { outfit: { name: "", garment_ids: [ garment.id ] } }
        end

        it "does not create the outfit and re-renders :new with 422" do
          expect {
            post outfits_path, params: invalid_params
          }.not_to change(Outfit, :count)
          expect(response).to have_http_status(:unprocessable_content)
        end
      end

      context "with a foreign garment id (IDOR)" do
        it "does not attach a garment the user doesn't own" do
          mine = create(:garment, user: user)
          stranger_piece = create(:garment)

          post outfits_path, params: {
            outfit: { name: "Sneaky", garment_ids: [ mine.id, stranger_piece.id ] }
          }

          outfit = user.outfits.find_by(name: "Sneaky")
          expect(outfit).to be_present
          expect(outfit.garment_ids).to eq([ mine.id ])
        end
      end
    end

    describe "GET /outfits/:id/edit" do
      it "returns a successful response" do
        get edit_outfit_path(outfit)
        expect(response).to have_http_status(:success)
      end
    end

    describe "PATCH /outfits/:id" do
      context "with valid params" do
        it "updates the outfit, redirects to its show, and sets the flash" do
          patch outfit_path(outfit), params: { outfit: { name: "New Name" } }

          expect(response).to redirect_to(outfit_path(outfit))
          expect(flash[:notice]).to match(/updated/i)
          expect(outfit.reload.name).to eq("New Name")
        end
      end

      context "with invalid params" do
        it "does not update the outfit and re-renders :edit with 422" do
          patch outfit_path(outfit), params: { outfit: { name: "" } }

          expect(response).to have_http_status(:unprocessable_content)
          expect(outfit.reload.name).not_to eq("")
        end
      end
    end

    describe "DELETE /outfits/:id" do
      it "destroys the outfit, redirects to index, and sets the flash" do
        outfit
        expect {
          delete outfit_path(outfit)
      }.to change(Outfit, :count).by(-1)

      expect(response).to redirect_to(outfits_path)
      expect(flash[:notice]).to match(/deleted/i)
      end
    end
  end

  context "when signed in is another user (IDOR sentinels)" do
    let(:other_outfit) { create(:outfit, user: other_user) }

    before { sign_in user }

    it "returns 404 when trying to show another user's outfit" do
      get outfit_path(other_outfit)
      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when trying to update another user's outfit" do
      patch outfit_path(other_outfit), params: { outfit: { name: "Hacked" } }
      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when trying to destroy another user's outfit" do
      delete outfit_path(other_outfit)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /outfits/:id visibility" do
    let(:owner) { create(:user) }
    let(:stranger) { create(:user) }
    let(:public_outfit) { create(:outfit, user: owner, visibility: :public) }
    let(:private_outfit) { create(:outfit, user: owner, visibility: :private) }

    it "shows a public outfit to an anonymous visitor" do
      get outfit_path(public_outfit)

      expect(response).to have_http_status(:ok)
    end

    it "returns 404 on a private outfit for an anonymous visitor" do
      get outfit_path(private_outfit)

      expect(response).to have_http_status(:not_found)
    end

    it "shows the owner their own private outfit" do
      sign_in owner
      get outfit_path(private_outfit)

      expect(response).to have_http_status(:ok)
    end

    it "returns 404 on another user's private outfit" do
      sign_in stranger
      get outfit_path(private_outfit)

      expect(response).to have_http_status(:not_found)
    end

    it "shows another user's public outfit to a signed-in visitor" do
      sign_in stranger
      get outfit_path(public_outfit)

      expect(response).to have_http_status(:ok)
    end

    it "prompts an anonymous visitor to log in instead of showing the comment form" do
      get outfit_path(public_outfit)

      expect(response.body).not_to include("Add a comment...")
      expect(response.body).to include("Log in")
    end
  end
end
