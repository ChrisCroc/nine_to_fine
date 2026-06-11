require "rails_helper"

RSpec.describe Garment, type: :model do
  describe "validations" do
    it "is valid with name, color, user and category" do
      garment = build(:garment)

      expect(garment).to be_valid
    end

    it "is invalid without a name" do
      garment = build(:garment, name: nil)

      expect(garment).not_to be_valid
      expect(garment.errors[:name]).to be_present
    end

    it "is invalid without a color" do
      garment = build(:garment, color: nil)

      expect(garment).not_to be_valid
      expect(garment.errors[:color]).to be_present
    end

    it "is invalid without a user" do
      garment = build(:garment, user: nil)

      expect(garment).not_to be_valid
      expect(garment.errors[:user]).to be_present
    end

    it "is invalid without a category" do
      garment = build(:garment, category: nil)

      expect(garment).not_to be_valid
      expect(garment.errors[:category]).to be_present
    end

    it "rejects a name longer than 200 characters" do
      garment = build(:garment, name: "a" * 201)

      expect(garment).not_to be_valid
      expect(garment.errors[:name]).to be_present
    end

    it "is invalid when color is not in the allowed list" do
      garment = build(:garment, color: "neon")

      expect(garment).not_to be_valid
      expect(garment.errors[:color]).to be_present
    end
  end

  describe "COLOR_HEX invariant" do
    it "maps every entry of COLORS to a hex value" do
      expect(Garment::COLOR_HEX.keys.sort).to eq(Garment::COLORS.sort),
        "Each colour in COLORS must have a hex value in COLOR_HEX (drift detected)"
    end
  end

  describe "associations" do
    it "can access its outfits through outfit_garments" do
      user = create(:user)
      garment = create(:garment, user: user)
      outfit = Outfit.create!(name: "Casual Friday", user: user, garments: [ garment ])

      expect(garment.outfits).to include(outfit)
    end

    it "can have tags through taggings" do
      user = create(:user)
      garment = create(:garment, user: user)
      tag = create(:tag, user: user)
      create(:tagging, tag: tag, taggable: garment)

      expect(garment.tags).to include(tag)
    end
  end

  describe "photo attachment (Active Storage)" do
    let(:user) { create(:user) }
    let(:garment) { create(:garment, user: user) }
    it "is valid with an attached image" do
      garment.photo.attach(
        io: file_fixture("valid.jpg").open,
        filename: "valid.jpg",
        content_type: "image/jpeg"
      )

      expect(garment).to be_valid
    end

    it "is valid without a photo" do
      expect(garment).to be_valid
    end

    it "rejects a non-image file" do
      garment.photo.attach(
        io: file_fixture("document.pdf").open,
        filename: "document.pdf",
        content_type: "application/pdf"
      )

      expect(garment).not_to be_valid
      expect(garment.errors[:photo]).not_to be_empty
    end

    it "rejects a file larger than 10MB" do
      garment.photo.attach(
        io: file_fixture("valid.jpg").open,
        filename: "valid.jpg",
        content_type: "image/jpeg"
      )
      garment.photo.blob.define_singleton_method(:byte_size) { 11.megabytes }

      expect(garment).not_to be_valid
      expect(garment.errors[:photo]).to be_present
    end
  end

  describe "tag_names= virtual attribute (Taggable concern)" do
    let(:user) { create(:user) }
    it "normalizes, strips, dedupes and creates tags on save" do
      garment = build(:garment, user: user, tag_names: "Casual, casual, SUMMER, ")
      garment.save!

      expect(garment.tags.pluck(:name).sort).to eq(%w[casual summer])
    end

    it "reuses an existing tag instead of creating a duplicate" do
      create(:tag, user: user, name: "summer")

      expect {
        build(:garment, user: user, tag_names: "summer").save!
    }.not_to change(user.tags, :count)
    end

    it "scopes tags to the garment's user" do
      garment = build(:garment, user: user, tag_names: "brandnew")
      garment.save!

      expect(garment.tags.first.user).to eq(user)
    end

    it "removes all tags when tag_names is set to an empty string" do
      garment = build(:garment, user: user, tag_names: "summer, casual")
      garment.save!

      garment.update!(tag_names: "")

      expect(garment.tags).to be_empty
    end

    it "preserves existing tags when saved without tag_names" do
      garment = build(:garment, user: user, tag_names: "summer, casual")
      garment.save!

      reloaded = Garment.find(garment.id)
      reloaded.update!(name: "Renamed")

      expect(reloaded.tags.count).to eq(2)
    end

    it "does not create orphan tags when the record is invalid" do
      expect {
        garment = build(:garment, user: user, name: "", tag_names: "shouldnotexist")
        expect(garment.save).to be false
    }.not_to change(Tag, :count)
    end

    it "returns tag names as a coma-joined string from the getter" do
      garment = build(:garment, user: user, tag_names: "alpha, beta")
      garment.save!

      expect(Garment.find(garment.id).tag_names.split(", ").sort).to eq(%w[alpha beta])
    end
  end
end
