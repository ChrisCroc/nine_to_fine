require "test_helper"

class OutfitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "is valid with a name and a user" do
    outfit = Outfit.new(name: "New Outfit", user: users(:chris))
    assert outfit.valid?
  end

  test "is invalid without a name" do
    outfit = Outfit.new(user: users(:chris))
    assert_not outfit.valid?
    assert_includes outfit.errors[:name], "can't be blank"
  end

  test "is invalid without a user" do
    outfit = Outfit.new(name: "Lonely outfit")
    assert_not outfit.valid?
    assert_includes outfit.errors[:user], "must exist"
  end

  test "rejects name longer than 200 characters" do
    outfit = Outfit.new(name: "a" * 201, user: users(:chris))
    assert_not outfit.valid?
    assert_includes outfit.errors[:name], "is too long (maximum is 200 characters)"
  end

  test "is invalid when the same user already has an outfit with the same name (case-insensitive)" do
    duplicate = Outfit.new(name: "casual friday", user: users(:chris))
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:name], "has already been taken"
  end

  test "is valid when another user has an outfit with the same name" do
    outfit = Outfit.new(name: "Casual Friday", user: users(:john))
    assert outfit.valid?
  end
end
