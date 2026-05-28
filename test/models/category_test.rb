require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "is valid with a name and a position" do
    category = Category.new(name: "Loungewear", position: 99)
    assert category.valid?
  end

  test "is invalid without a name" do
    category = Category.new(position: 1)
    assert_not category.valid?
    assert_includes category.errors[:name], "can't be blank"
  end

  test "is invalid when name is already taken (case-insensitive)" do
    duplicate = Category.new(name: "Top", position: 99)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:name], "has already been taken"
  end

  test "is invalid without a position" do
    category = Category.new(name: "Loungewear")
    assert_not category.valid?
    assert_includes category.errors[:position], "can't be blank"
  end

  test "cannot be destroyed when garments exist" do
    skip "Attendre la génération du modèle Garment"
    # category = categories(:top)
    # Garment.create!(name: "T-shirt", user: users(:chris), category: category)
    # assert_not category.destroy
    # assert_includes category.errors[:base], /restrict/i
    # assert Category.exists?(category.id)
  end

  test "DB rejects duplicate name even with validations bypassed" do
    duplicate = Category.new(name: "TOP", position: 99)
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
