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
end
