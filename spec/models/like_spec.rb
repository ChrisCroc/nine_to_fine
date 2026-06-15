require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      like = build(:like)

      expect(like).to be_valid
    end
    it "is invalid without a user" do
      like = build(:like, user: nil)

      expect(like).not_to be_valid
      expect(like.errors[:user]).to be_present
    end
    it "is invalid without likeable" do
      like = build(:like, likeable: nil)

      expect(like).not_to be_valid
      expect(like.errors[:likeable]).to be_present
    end
  end
  describe "uniqueness scopded to (user_id, likeable_type, likeable_id)" do
    let(:user) { create(:user) }
    let(:outfit) { create(:outfit) }
    it "is invalid when the same user likes the same outfit" do
      create(:like, user: user, likeable: outfit)
      duplicate = build(:like, user: user, likeable: outfit)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:user_id]).to be_present
    end
    it "allows the same user to like 2 different outfits" do
      another_outfit = create(:outfit)
      create(:like, user: user, likeable: outfit)
      second_like = build(:like, user: user, likeable: another_outfit)

      expect(second_like).to be_valid
    end

    it "allows 2 different users to like the same outfit" do
      another_user = create(:user)
      create(:like, user: user, likeable: outfit)
      second_like = build(:like, user: another_user, likeable: outfit)

      expect(second_like).to be_valid
    end

    it "raises RecordNotUnique at DB level if validation is bypassed" do
      create(:like, user: user, likeable: outfit)
      duplicate = build(:like, user: user, likeable: outfit)

      expect { duplicate.save(validate: false) }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe "polymorphic association" do
    it "resolves likeable to the actual outfit instance" do
      outfit = create(:outfit)
      like = create(:like, likeable: outfit)

      expect(like.likeable).to eq(outfit)
      expect(like.likeable).to be_a(Outfit)
      expect(like.likeable_type).to eq("Outfit")
    end
  end
end
