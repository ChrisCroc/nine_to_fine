require "rails_helper"

RSpec.describe Outfit, type: :model do
  describe "validations" do
    it "is valid with a name, a user and at least one garment" do
      outfit = build(:outfit)

      expect(outfit).to be_valid
    end

    it "is invalid without a name" do
      outfit = build(:outfit, name: nil)

      expect(outfit).not_to be_valid
      expect(outfit.errors[:name]).to be_present
    end

    it "is invalid without a user" do
      outfit = build(:outfit, user: nil)

      expect(outfit).not_to be_valid
      expect(outfit.errors[:user]).to be_present
    end

    it "is invalid without at least one garment" do
      user = create(:user)
      outfit = Outfit.new(name: "Empty outfit", user: user)

      expect(outfit).not_to be_valid
      expect(outfit.errors[:garments]).to be_present
    end

    it "rejects a name longer than 200 characters" do
      outfit = build(:outfit, name: "a" * 201)

      expect(outfit).not_to be_valid
      expect(outfit.errors[:name]).to be_present
    end

    it "is invalid when the same user already has an outfit with that name (case-insensitive)" do
      user = create(:user)
      create(:outfit, name: "Casual Friday", user: user)
      duplicate = build(:outfit, name: "Casual Friday", user: user)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:name]).to be_present
    end

    it "is valid when another user already has an outfit with the same name" do
      user1 = create(:user)
      user2 = create(:user)
      create(:outfit, name: "Casual Friday", user: user1)
      outfit = build(:outfit, name: "Casual Friday", user: user2)

      expect(outfit).to be_valid
    end
  end
  describe "associations" do
    it "can access its garments through outfit_garments" do
      user = create(:user)
      garment_a = create(:garment, user: user)
      garment_b = create(:garment, user: user)
      outfit = create(:outfit, user: user, garments: [ garment_a, garment_b ])

      expect(outfit.garments.count).to eq(2)
      expect(outfit.garments).to include(garment_a)
    end

    it "can have tags through taggings" do
      user = create(:user)
      outfit = create(:outfit, user: user)
      tag = create(:tag, user: user)
      create(:tagging, tag: tag, taggable: outfit)

      expect(outfit.tags).to include(tag)
    end
  end

  describe "Taggable concern integration" do
    it "creates and assigns tags through tag_names= setter" do
      user = create(:user)
      outfit = build(:outfit, user: user, tag_names: "evening, Casual")
      outfit.save!
      expect(outfit.tags.pluck(:name).sort).to eq(%w[casual evening])
    end
  end

  describe ".tagged_with_all" do
    let(:chris) { create(:user) }
    let(:summer) { create(:tag, name: "summer", user: chris) }
    let(:chic) { create(:tag, name: "chic", user: chris) }
    let(:summer_and_chic) { create(:outfit, user: chris) }
    let(:summer_only) { create(:outfit, user: chris) }

    before do
      create(:tagging, tag: summer, taggable: summer_and_chic)
      create(:tagging, tag: chic, taggable: summer_and_chic)
      create(:tagging, tag: summer, taggable: summer_only)
    end
    it "keeps outfits that have ALL requested tags" do
      result = Outfit.tagged_with_all([ summer.id, chic.id ])

      expect(result).to include(summer_and_chic)
    end

    it "excludes an outfit that has only one of the requested tags (AND, not OR)" do
      result = Outfit.tagged_with_all([ summer.id, chic.id ])

      expect(result).not_to include(summer_only)
    end

    it "matches an outfit that has the requested tags plus extra ones" do
      create(:tagging, tag: create(:tag, name: "winter", user: chris), taggable: summer_and_chic)
      result = Outfit.tagged_with_all([ summer.id, chic.id ])

      expect(result).to include(summer_and_chic)
    end
  end

  describe "visibility" do
    it "defaults to private" do
      expect(build(:outfit).visibility_private?).to be true
    end
  end

  describe "#visible_to?" do
    let(:owner) { create(:user) }
    let(:other) { create(:user) }

    it "makes a public outfit visible to anyone, nil included" do
      outfit = create(:outfit, user: owner, visibility: :public)
      expect(outfit.visible_to?(other)).to be true
      expect(outfit.visible_to?(nil)).to be true
    end

    it "keeps a private outfit visible to its owner only" do
      outfit = create(:outfit, user: owner, visibility: :private)

      expect(outfit.visible_to?(owner)).to be true
      expect(outfit.visible_to?(other)).to be false
      expect(outfit.visible_to?(nil)).to be false
    end
  end

  describe ".visibility_public" do
    it "returns only public outfits" do
      owner = create(:user)
      pub = create(:outfit, user: owner, visibility: :public)
      create(:outfit, user: owner, visibility: :private)
      expect(Outfit.visibility_public).to eq [ pub ]
    end
  end
end
