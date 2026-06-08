require "test_helper"

class GarmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "is valid with name, color, user and category" do
    garment = Garment.new(
      name: "Test shirt",
      color: "white",
      user: users(:chris),
      category: categories(:top)
    )
    assert garment.valid?
  end

  test "is invalid without a name" do
    garment = Garment.new(
      color: "red",
      user: users(:chris),
      category: categories(:top)
    )
    assert_not garment.valid?
    assert_includes garment.errors[:name], "can't be blank"
  end

  test "is invalid without a color" do
    garment = Garment.new(
      name: "Test pants",
      user: users(:chris),
      category: categories(:bottom)
    )
    assert_not garment.valid?
    assert_includes garment.errors[:color], "can't be blank"
  end

  test "is invalid without a user" do
    garment = Garment.new(
      name: "Test jacket",
      color: "black",
      category: categories(:outerwear)
    )
    assert_not garment.valid?
    assert_includes garment.errors[:user], "must exist"
  end

  test "is invalid without a category" do
    garment = Garment.new(
      name: "Test shoes",
      color: "brown",
      user: users(:chris)
    )
    assert_not garment.valid?
    assert_includes garment.errors[:category], "must exist"
  end

  test "rejects name longer than 200 characters" do
    long_name = "a" * 201
    garment = Garment.new(
      name: long_name,
      color: "blue",
      user: users(:chris),
      category: categories(:top)
    )
    assert_not garment.valid?
    assert_includes garment.errors[:name], "is too long (maximum is 200 characters)"
  end

  test "can access its outfits through outfit_garments" do
    garment = garments(:black_tshirt)
    assert_includes garment.outfits, outfits(:casual_friday)
  end

  test "can have tags through taggings" do
    garment = garments(:black_tshirt)
    assert_includes garment.tags, tags(:summer)
  end

  test "is valid with an attached image" do
    garment = garments(:black_tshirt)
    garment.photo.attach(io: file_fixture("valid.jpg").open, filename: "valid.jpg", content_type: "image/jpeg")
    assert garment.valid?
  end

  test "is valid without a photo" do
    assert garments(:black_tshirt).valid?
  end

  test "rejects a non-image file" do
    garment = garments(:black_tshirt)
    garment.photo.attach(io: file_fixture("document.pdf").open, filename: "document.pdf", content_type: "application/pdf")
    assert_not garment.valid?
    assert garment.errors[:photo].any?
  end

  test "rejects a file larger than 10MB" do
    garment = garments(:black_tshirt)
    garment.photo.attach(io: file_fixture("valid.jpg").open, filename: "valid.jpg", content_type: "image/jpeg")
    garment.photo.blob.define_singleton_method(:byte_size) { 11.megabytes }
    assert_not garment.valid?
    assert_includes garment.errors[:photo], "must be smaller than 10MB"
  end

  test "tag_names= normalizes, strips, dedupes and creates tags on save" do
    garment = build_garment(tag_names: "Casual, casual, SUMMER, ")
    garment.save!
    assert_equal %w[casual summer], garment.tags.pluck(:name).sort
  end

  test "reuses an existing tag instead of creating a duplicate" do
    # chris already has the tag "summer" (fixture) -> find_or_create_by must REUSE it
    assert_no_difference -> { users(:chris).tags.count } do
      build_garment(tag_names: "summer").save!
    end
  end

  test "scopes tags to the garment's user" do
    garment = build_garment(user: users(:chris), tag_names: "brandnew").tap(&:save!)
    assert_equal users(:chris), garment.tags.first.user
  end

  test "clearing the field removes all tags" do
    garment = build_garment(tag_names: "summer, casual").tap(&:save!)
    garment.update!(tag_names: "")
    assert_empty garment.tags
  end

  test "saving without tag_names preserves existing tags" do
    garment = build_garment(tag_names: "summer, casual").tap(&:save!)
    reloaded = Garment.find(garment.id) # New object : @tag_names is nil
    reloaded.update!(name: "Renamed")
    assert_equal 2, reloaded.tags.count
  end

  test "does not create orphan tags when the record is invalid" do
    assert_no_difference -> { Tag.count } do
      garment = build_garment(name: "", tag_names: "shouldnotexist")
      assert_not garment.save # empty name -> validation fails -> after_save doesn't run
    end
  end

  test "tag_names getter returns the tags as a comma-joined string" do
    garment = build_garment(tag_names: "alpha, beta").tap(&:save!)
    assert_equal "alpha, beta", Garment.find(garment.id).tag_names
  end

  test "is invalid when color is not in th eallowed list" do
    garment = Garment.new(name: "Test tshirt", color: "neon", user: users(:chris), category: categories(:top))

    assert_not garment.valid?
    assert_includes garment.errors[:color], "is not included in the list"
  end

private

  def build_garment(attrs = {})
    Garment.new({ name: "Test piece", color: "white", user: users(:chris), category: categories(:top) }.merge(attrs))
  end
end
