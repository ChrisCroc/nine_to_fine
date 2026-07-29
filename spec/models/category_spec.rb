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
      category = create(:category, :leaf)
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

  describe "self-join hierarchy" do
    it "a leaf belongs to its parent" do
      parent = create(:category)
      leaf = create(:category, parent: parent)

      expect(leaf.parent).to eq(parent)
    end

    it "a parent has_many subcategories ordered by position" do
      parent = create(:category)
      b = create(:category, parent: parent, position: 2)
      a = create(:category, parent: parent, position: 1)

      expect(parent.subcategories).to eq([ a, b ])
    end

    it ".parents returns only top-level categories, ordered by position" do
      p2 = create(:category, position: 2)
      p1 = create(:category, position: 1)
      create(:category, parent: p1)

      expect(Category.parents).to eq([ p1, p2 ])
    end

    it ".leaves returns only categories that have a parent" do
      parent = create(:category)
      leaf = create(:category, parent: parent)

      expect(Category.leaves).to contain_exactly(leaf)
    end
  end

  describe "depth validation (2 levels max)" do
    it "rejects a grandchild (a leaf cannot become a parent)" do
      parent = create(:category)
      leaf = create(:category, parent: parent)
      grandchild = build(:category, parent: leaf)

      expect(grandchild).to be_invalid
      expect(grandchild.errors[:parent]).to include("must be a top-level category")
    end

    it "accepts a leaf under a top-level parent" do
      parent = create(:category)

      expect(build(:category, parent: parent)).to be_valid
    end
  end
end
