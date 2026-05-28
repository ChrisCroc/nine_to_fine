require "test_helper"

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "is valid with a name and a user" do
    tag = Tag.new(name: "casual", user: users(:chris))
    assert tag.valid?
  end

  test "is invalid without a name" do
    tag = Tag.new(user: users(:chris))
    assert_not tag.valid?
    assert_includes tag.errors[:name], "can't be blank"
  end

  test "is invalid without a user" do
    tag = Tag.new(name: "casual")
    assert_not tag.valid?
    assert_includes tag.errors[:user], "must exist"
  end

  test "rejects name longer than 50 characters" do
    tag = Tag.new(name: "a" * 51, user: users(:chris))
    assert_not tag.valid?
    assert_includes tag.errors[:name], "is too long (maximum is 50 characters)"
  end

  test "is invalid when the same user already has a tag with the same name (case-insensitive)" do
    duplicate = Tag.new(name: "SUMMER", user: users(:chris))
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:name], "has already been taken"
  end

  test "is valid when another user has a tag with the same name" do
    tag = Tag.new(name: "summer", user: users(:john))
    assert tag.valid?
  end
end
