require "rails_helper"

RSpec.describe Tagging, type: :model do
  describe "validations" do
    let(:user) { create(:user) }
    it "is valid tagging a garment" do
      tagging = build(:tagging, tag: create(:tag, user: user), taggable: create(:garment, user: user))

      expect(tagging).to be_valid
    end

    it "is valid tagging an outfit" do
      tagging = build(:tagging, tag: create(:tag, user: user), taggable: create(:outfit, user: user))

      expect(tagging).to be_valid
    end

    it "is invalid without a tag" do
      tagging = build(:tagging, tag: nil)

      expect(tagging).not_to be_valid
      expect(tagging.errors[:tag]).to be_present
    end

    it "is invalid without taggable" do
      tagging = build(:tagging, taggable: nil)

      expect(tagging).not_to be_valid
      expect(tagging.errors[:taggable]).to be_present
    end

    it "rejects the same tag applied twice to the same taggable" do
      garment = create(:garment, user: user)
      tag = create(:tag, user: user)
      create(:tagging, tag: tag, taggable: garment)
      duplicate = build(:tagging, tag: tag, taggable: garment)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:tag_id]).to be_present
    end

    it "allows the same tag on different taggable" do
      garment_a = create(:garment, user: user)
      garment_b = create(:garment, user: user)
      tag = create(:tag, user: user)
      create(:tagging, tag: tag, taggable: garment_a)
      tagging = build(:tagging, tag: tag, taggable: garment_b)

      expect(tagging).to be_valid
    end
  end
end
