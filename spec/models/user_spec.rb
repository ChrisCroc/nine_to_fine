require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with username, email and password" do
      user = build(:user)

      expect(user).to be_valid
    end

    it "is invalid without a username" do
      user = build(:user, username: nil)

      expect(user).not_to be_valid
      expect(user.errors[:username]).to be_present
    end

    it "is invalid when username is already taken" do
      create(:user, username: "chris")
      duplicate = build(:user, username: "chris")

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:username]).to be_present
    end

    it "rejects a username shorter than 3 characters" do
      user = build(:user, username: "Al")

      expect(user).not_to be_valid
      expect(user.errors[:username]).to be_present
    end
  end

  describe "associations and dependent destroy" do
    it "is invalid without an email" do
      user = build(:user, email: nil)

      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it "is invalid with a malformed email" do
      user = build(:user, email: "not an email")

      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it "is invalid when email is already taken (case-insensitive)" do
      create(:user, email: "chris@example.com")
      duplicate = build(:user, email: "CHRIS@example.com")

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:email]).to be_present
    end

    it "is invalid without a password" do
      user = build(:user, password: nil)

      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_present
    end

    it "rejects a password shorter than 6 characters" do
      user = build(:user, password: "12345")

      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_present
    end
  end

  describe "associations and dependent destroy" do
    it "destroys associated garments when destroyed" do
      user = create(:user)
      create(:garment, user: user)

      expect { user.destroy }.to change(Garment, :count).by(-1)
    end

    it "destroys associated outfits when destroyed" do
      user = create(:user)
      Outfit.create!(
        name: "Casual Friday",
        user: user,
        garments: [ create(:garment, user: user) ]
      )

      expect { user.destroy }.to change(Outfit, :count).by(-1)
    end

    it "destroys associated tags when destroyed" do
      user = create(:user)
      create(:tag, user: user)

      expect { user.destroy }.to change(Tag, :count).by(-1)
    end
  end

  it "destroys associated garments, outfits, and tags" do
    user= create(:user)
    create(:garment, user: user)
    Outfit.create!(name: "X", user: user, garments: [ create(:garment, user: user) ])
    create(:tag, user: user)

    expect { user.destroy }
      .to change(Outfit, :count).by(-1)
      .and change(Garment, :count).by(-2)
      .and change(Tag, :count).by(-1)
  end

  describe "what an account deletion leaves behind" do
    it "leaves no orphaned tagging" do
      user = create(:user)
      garment = create(:garment, user: user)
      create(:tagging, tag: create(:tag, user: user), taggable: garment)

      expect { user.destroy }.to change(Tagging, :count).by(-1)
      expect(Tagging.all.reject(&:taggable)).to be_empty
    end

    it "leaves no orphaned outfit_garment" do
      user = create(:user)
      create(:outfit, user: user)

      expect { user.destroy }.to change(OutfitGarment, :count).by(-1)
      expect(OutfitGarment.all.reject { |link| link.garment && link.outfit }).to be_empty
    end

    it "decrements the follower counter of an account that remains" do
      leaver = create(:user)
      stayer = create(:user)
      Follow.create!(follower: leaver, followed: stayer)

      expect { leaver.destroy }.to change { stayer.reload.followers_count }.from(1).to(0)
    end

    it "decrements the following counter of an account that remains" do
      leaver = create(:user)
      stayer = create(:user)
      Follow.create!(follower: stayer, followed: leaver)

      expect { leaver.destroy }.to change { stayer.reload.following_count }.from(1).to(0)
    end

    it "decrements the like counter of an outfit that remains" do
      leaver = create(:user)
      outfit = create(:outfit, user: create(:user))
      create(:like, user: leaver, likeable: outfit)

      expect { leaver.destroy }.to change { outfit.reload.likes_count }.from(1).to(0)
    end

    it "decrements the comment counter of an outfit that remains" do
      leaver = create(:user)
      outfit = create(:outfit, user: create(:user))
      Comment.create!(user: leaver, outfit: outfit, body: "Nice one")

      expect { leaver.destroy }.to change { outfit.reload.comments_count }.from(1).to(0)
    end
  end

  describe ".search_by_username" do
    let!(:henry) { create(:user, username: "henrystyle") }
    let!(:henrietta) { create(:user, username: "henrietta") }
    let!(:bob) { create(:user, username: "bob") }

    it "matches usernames partially, case-insensitively" do
      expect(User.search_by_username("HEN")).to contain_exactly(henry, henrietta)
    end

    it "returns none for blank query" do
      expect(User.search_by_username("")).to be_empty
      expect(User.search_by_username(nil)).to be_empty
    end

    it "escapes SQL LIKE wildcards" do
      expect(User.search_by_username("%")).to be_empty
    end

    it "caps results at 10" do
      create_list(:user, 12)

      expect(User.search_by_username("username").to_a.length).to eq(10)
    end
  end
end
