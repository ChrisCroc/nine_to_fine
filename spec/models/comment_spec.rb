require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      expect(build(:comment)).to be_valid
    end

    it "is invalid without a body" do
      comment = build(:comment, body: nil)

      expect(comment).not_to be_valid
      expect(comment.errors[:body]).to be_present
    end

    it "is invalid with a body longer than 1000 characters" do
      comment = build(:comment, body: "a" * 1001)

      expect(comment).to be_invalid
      expect(comment.errors[:body]).to be_present
    end
  end

  describe "associations" do
    it "belongs to the user and a outfit" do
      comment = create(:comment)

      expect(comment.user).to be_a(User)
      expect(comment.outfit).to be_a(Outfit)
    end
  end

  describe "counter_cache on outfit" do
    it "increments comments_count on create" do
      outfit = create(:outfit)

      expect {
        create(:comment, outfit: outfit)
    }.to change { outfit.reload.comments_count }.from(0).to(1)
    end

    it "decrements comments_count on outfit" do
      outfit = create(:outfit)
      comment = create(:comment, outfit: outfit)

      expect {
        comment.destroy
    }.to change { outfit.reload.comments_count }.by(-1)
    end
  end

  describe "ordering" do
    it "returns comments newest-first via the association" do
      outfit = create(:outfit)
      older = create(:comment, outfit: outfit, created_at: 2.hours.ago)
      newer = create(:comment, outfit: outfit, created_at: 1.minute.ago)

      expect(outfit.comments.to_a).to eq([newer, older])
    end
  end
end
