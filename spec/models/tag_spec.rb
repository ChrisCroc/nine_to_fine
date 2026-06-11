require "rails_helper"

RSpec.describe Tag, type: :model do
  describe "validations" do

    it "is valid with a name and a user" do
      tag = build(:tag, name: "casual")

      expect(tag).to be_valid
    end

    it "is invalid without a name" do
      tag = build(:tag, name: nil)

      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to be_present
    end

    it "is invalid without a user" do
      tag = build(:tag, user: nil)

      expect(tag).not_to be_valid
      expect(tag.errors[:user]).to be_present
    end

    it "rejects a name longer than 50 characters" do
      tag = build(:tag, name: "a" * 51)

      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to be_present
    end

    it "is invalid when the same user already has a tag with that name (case-insensitive)" do
      user = create(:user)
      create(:tag, name: "summer", user: user)
      duplicate = build(:tag, name: "SUMMER", user: user)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:name]).to be_present
    end

    it "is valid when another user already has a tag with the same name" do
      user1 = create(:user)
      user2 = create(:user)
      create(:tag, name: "summer", user: user1)
      tag = build(:tag, name: 'summer', user: user2)

      expect(tag).to be_valid
    end
  end

  describe "#tagged_garment" do
    it "returns only garments tagged with this tag (not outfits)" do
      user = create(:user)
      tag = create(:tag, user: user)
      garment = create(:garment, user: user)
      outfit = Outfit.create!(
          name: "Casual Friday",
          user: user,
          garments: [ create(:garment, user: user) ]
      )
      create(:tagging, tag: tag, taggable: garment)
      create(:tagging, tag: tag, taggable: outfit)

      expect(tag.tagged_garments).to include(garment)
      expect(tag.tagged_garments).not_to include(outfit)
    end
  end

  describe "#tagged_outfits" do
    it "returns only outfits tagged with this tag (not garments)" do
      user = create(:user)
      tag = create(:tag, user: user)
      garment = create(:garment, user: user)
      outfit = Outfit.create!(
        name: "Business",
        user: user,
        garments: [ create(:garment, user: user) ]
      )
      create(:tagging, tag: tag, taggable: outfit)
      create(:tagging, tag: tag, taggable: garment)

      expect(tag.tagged_outfits).to include(outfit)
      expect(tag.tagged_outfits).not_to include(garment)
    end
  end
end
