require "rails_helper"

RSpec.describe "Adding a garment from a photo", type: :system do
  let(:user) { create(:user) }
  let!(:shirt) { create(:category, name: "shirt", parent: create(:category, name: "Tops")) }

  before do
    # Only the call to the model is replaced. Everything around it is real:
    # the file input, the fetch to /garments/analyses, the JSON, and the
    # Stimulus controller that fills each field.
    result = Ai::GarmentTagger::Result.new(
      color: "white", category_id: shirt.id, name: "White linen shirt",
      formality: "smart_casual", season: "summer", pattern: "solid"
    )
    allow(Ai::GarmentTagger).to receive(:new).and_return(instance_double(Ai::GarmentTagger, tag: result))
    sign_in user
  end

  it "fills the form from the photo, then saves the piece as analysed" do
    visit new_garment_path
    attach_file "Photo", file_fixture("valid.jpg")

    expect(page).to have_field("Name", with: "White linen shirt")
    expect(page).to have_select("Category", selected: "shirt")
    expect(page).to have_select("Season", selected: "Summer")

    click_button "Create Garment"

    expect(page).to have_content("Garment was successfully created.")
    # reload: sign_in hands THIS user object to the first request, and
    # garments#new left an empty, unsaved garment in its association.
    garment = user.garments.reload.last
    expect(garment).to have_attributes(name: "White linen shirt", color: "white", category: shirt, season: "summer")
    expect(garment.ai_analyzed_at).to be_present
  end
end
