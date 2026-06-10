require "test_helper"

class GarmentFilterTest < ActiveSupport::TestCase
  setup do
    @chris_scope = users(:chris).garments
  end

  test "results return the input scope unchanged when params is empty" do
    result_empty = GarmentFilter.new(@chris_scope, {}).results
    result_nil = GarmentFilter.new(@chris_scope, nil).results

    assert_equal @chris_scope.pluck(:id).sort, result_empty.pluck(:id).sort
    assert_equal @chris_scope.pluck(:id).sort, result_nil.pluck(:id).sort
  end

  test "results filters by color" do
    result = GarmentFilter.new(@chris_scope, { color: "black" }).results

    assert_includes result, garments(:black_tshirt)
    refute_includes result, garments(:blue_jeans)
  end

  test "results filters by category_id" do
    result = GarmentFilter.new(@chris_scope, { category_id: categories(:top).id }).results

    assert_includes result, garments(:black_tshirt)
    refute_includes result, garments(:blue_jeans)
  end

  test "results filters by tag_id (joins taggings and tags)" do
    result = GarmentFilter.new(@chris_scope, { tag_id: tags(:summer).id }).results

    assert_includes result, garments(:black_tshirt)
    refute_includes result, garments(:blue_jeans)
  end

  test "results filters by brand" do
    result = GarmentFilter.new(@chris_scope, { brand: "Levi's" }).results

    assert_includes result, garments(:blue_jeans)
    refute_includes result, garments(:black_tshirt)
  end

  test "results filters by color AND category_id combined" do
    result = GarmentFilter.new(@chris_scope, { color: "black", category_id: categories(:top).id }).results

    assert_includes result, garments(:black_tshirt)
    refute_includes result, garments(:blue_jeans)
  end

  test "results filters by all 4 filters combined (color + category + tag + brand)" do
    result = GarmentFilter.new(@chris_scope, { color: "black", category_id: categories(:top).id, tag_id: tags(:summer).id, brand: "Uniqlo" }).results

    assert_includes result, garments(:black_tshirt)
    refute_includes result, garments(:blue_jeans)
  end

  test "results ignores unknown keys silently" do
    result = GarmentFilter.new(@chris_scope, { color: "black", hacker: "DROP TABLE garments;" }).results

    assert_includes result, garments(:black_tshirt)
    refute_includes result, garments(:blue_jeans)
  end

  test "results ignores blanck filter values" do
    result = GarmentFilter.new(@chris_scope, { color: "" }).results

    assert_equal @chris_scope.pluck(:id).sort, result.pluck(:id).sort
  end

  test "results never leaks records from other users even when filter matches" do
    result = GarmentFilter.new(@chris_scope, { color: "black" }).results

    assert_includes result, garments(:black_tshirt)
    refute_includes result, garments(:black_jacket)
  end

  test "results filters by search with partial ILIKE match" do
    result = GarmentFilter.new(@chris_scope, { search: "shirt" }).results

    assert_includes result, garments(:black_tshirt)
    refute_includes result, garments(:blue_jeans)
  end

  test "results filters by search and by color with AND" do
    result = GarmentFilter.new(@chris_scope, { search: "jea", color: "blue" }).results

    assert_includes result, garments(:blue_jeans)
    refute_includes result, garments(:black_tshirt)
  end

  test "results escapes % wildcard in search" do
    result = GarmentFilter.new(@chris_scope, { search: "%" }).results
    refute_equal @chris_scope.pluck(:id).sort, result.pluck(:id).sort
  end
end
