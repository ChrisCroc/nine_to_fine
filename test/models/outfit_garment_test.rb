require "test_helper"

class OutfitGarmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "is valid with an outfit and a garment" do
    og = OutfitGarment.new(outfit: outfits(:weekend_brunch), garment: garments(:black_tshirt))
    assert og.valid?
  end

  test "is invalid without an outfit" do
    og = OutfitGarment.new(garment: garments(:black_tshirt))
    assert_not og.valid?
    assert_includes og.errors[:outfit], "must exist"
  end

  test "is invalid without a garment" do
    og = OutfitGarment.new(outfit: outfits(:weekend_brunch))
    assert_not og.valid?
    assert_includes og.errors[:garment], "must exist"
  end

  test "rejects same garment twice in the same outfit" do
    duplicate = OutfitGarment.new(outfit: outfits(:casual_friday), garment: garments(:black_tshirt))
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:garment_id], "has already been taken"
  end

  test "allows same garment in different outfits" do
    og = OutfitGarment.new(outfit: outfits(:weekend_brunch), garment: garments(:black_tshirt))
    assert og.valid?
  end
end
