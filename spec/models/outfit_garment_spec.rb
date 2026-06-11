require "rails_helper"

RSpec.describe OutfitGarment, type: :model do
  describe "validations" do

    it "is valid with an outfit and a garment" do
      outfit_garment = build(:outfit_garment)

      expect(outfit_garment).to be_valid
    end

    it "is invalid without an outfit" do
      outfit_garment = build(:outfit_garment, outfit: nil)

      expect(outfit_garment).not_to be_valid
      expect(outfit_garment.errors[:outfit]).to be_present
    end

    it "is invalid without a garment" do
      outfit_garment = build(:outfit_garment, garment: nil)

      expect(outfit_garment).not_to be_valid
      expect(outfit_garment.errors[:garment]).to be_present
    end

    it "rejects the same garment twice in the same outfit" do
      user = create(:user)
      garment = create(:garment, user: user)
      outfit = create(:outfit, user: user, garments: [garment])
      duplicate = build(:outfit_garment, outfit: outfit, garment: garment)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:garment_id]).to be_present
    end

    it "allows the same garment in different outfits" do
      user = create(:user)
      garment = create(:garment, user: user)
      outfit_a = create(:outfit, user: user, garments: [garment])
      outfit_b = create(:outfit, user: user)

      outfit_garment = build(:outfit_garment, outfit: outfit_b, garment: garment)

      expect(outfit_garment).to be_valid
    end
  end
end
