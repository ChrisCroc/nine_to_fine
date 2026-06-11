require "rails_helper"

RSpec.describe Category, type: :model do

  describe "validations" do
    it "is valid with a name and a position" do
      category = build(:category, name: "Loungewear", position: 99)

      expect(category).to be_valid
    end

    it "is invalild without a name" do
      category = build(:category, name: nil)

      expect(category).not_to be_valid
      expect(category.errors[:name]).to be_present
    end

    it "is invalid when a name is already taken (case-insensitive)" do
      create(:category, name: "Top")
      duplicate = build(:category, name: "TOP")

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:name]).to be_present
    end

    it "is invalid when position is not an integer" do
      category = build(:category, position: nil)

      expect(category).not_to be_valid
      expect(category.errors[:position]).to be_present
    end

    it "is invalid when position is not an integer" do
      category = build(:category, position: 3.14)

      expect(category).not_to be_valid
      expect(category.errors[:position]).to be_present
    end
  end

  describe "#destroy" do
    it "is blocked when garments exist (dependent: :restrict_with_error)" do
      category = create(:category)
      create(:garment, category: category)

      expect(category.destroy).to be false
      expect(category.errors[:base]).not_to be_empty
      expect(Category.exists?(category.id)).to be true
    end
  end

  describe "DB-level uniqueness constraint" do
    it "rejects duplicate annme even when Rails validations are bypassed" do
      create(:category, name: "Top")
      duplicate = build(:category, name: "TOP")

      expect {
        duplicate.save(validate: false)
    }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
