require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      follow = build(:follow)

      expect(follow).to be_valid
    end
    it "is invalid following the same user twice" do
      follow = create(:follow)
      duplicate = build(:follow, follower: follow.follower, followed: follow.followed)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:follower_id]).to be_present
    end

    it "is invalid when following yourself" do
      user = create(:user)
      follow = build(:follow, follower: user, followed: user)

      expect(follow).not_to be_valid
      expect(follow.errors[:followed_id]).to be_present
    end

    it "raises RecordNotUnique at DB level if validation is bypassed" do
      follow = create(:follow)
      duplicate = build(:follow, follower: follow.follower, followed: follow.followed)

      expect {
        duplicate.save(validate: false)
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe "counter_cache" do
    let(:alice) { create(:user) }
    let(:bob) { create(:user) }

    it "increments the follower's following_count when a follow is created" do
      expect {
        create(:follow, follower: alice, followed: bob)
      }.to change { alice.reload.following_count }.from(0).to(1)
    end

    it "increments the followed's followers_count when a follow is created" do
      expect {
        create(:follow, follower: alice, followed: bob)
      }.to change { bob.reload.followers_count }.from(0).to(1)
    end
  end

  describe "self-referential associations" do
    let(:alice) { create(:user) }
    let(:bob) { create(:user) }

    it "exposes followed_users on the follower" do
      create(:follow, follower: alice, followed: bob)

      expect(alice.followed_users).to include(bob)
    end

    it "exposes followers on the folloew" do
      create(:follow, follower: alice, followed: bob)

      expect(bob.followers).to include(alice)
    end

    it "answers following? in both direction" do
      create(:follow, follower: alice, followed: bob)

      expect(alice.following?(bob)).to be true
      expect(bob.following?(alice)).to be false
    end
  end
end
