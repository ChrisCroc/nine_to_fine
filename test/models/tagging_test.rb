require "test_helper"

class TaggingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "is valid tagging a garment" do
    tagging = Tagging.new(tag: tags(:business), taggable: garments(:black_tshirt))
    assert tagging.valid?
  end

  test "is valid tagging an outfit" do
    tagging = Tagging.new(tag: tags(:summer), taggable: outfits(:casual_friday))
    assert tagging.valid?
  end

  test "is invalid without a tag" do
    tagging = Tagging.new(taggable: garments(:black_tshirt))
    assert_not tagging.valid?
    assert_includes tagging.errors[:tag], "must exist"
  end

  test "is invalid without a taggable" do
    tagging = Tagging.new(tag: tags(:summer))
    assert_not tagging.valid?
    assert_includes tagging.errors[:taggable], "must exist"
  end

  test "rejects same tag applied twice to the same garment" do
    duplicate = Tagging.new(tag: tags(:summer), taggable: garments(:black_tshirt))
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:tag_id], "has already been taken"
  end

  test "allows same tag on different taggables" do
    tagging = Tagging.new(tag: tags(:summer), taggable: outfits(:weekend_brunch))
    assert tagging.valid?
  end
end
