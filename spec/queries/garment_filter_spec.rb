require "rails_helper"

RSpec.describe GarmentFilter do
  let(:chris) { create(:user, username: "chris") }
  let(:john) { create(:user, username: "john") }

  let(:top)       { create(:category, name: "Top", position: 1) }
  let(:bottom)    { create(:category, name: "Bottom", position: 2) }
  let(:outerwear) { create(:category, name: "Outerwear", position: 3) }

  let(:summer) { create(:tag, name: "summer", user: chris) }

  let!(:black_tshirt) do
    create(:garment, user: chris, category: top, name: "Black T-shirt", color: "black", brand: "Uniqlo")
  end
  let!(:blue_jeans) do
    create(:garment, user: chris, category: bottom, name: "Blue Jeans", color: "blue", brand: "Levi's")
  end
  let!(:black_jacket) do
    create(:garment, user: john, category: outerwear, name: "Black Jacket", color: "black", brand: "Uniqlo")
  end

  let(:chris_scope) { chris.garments }

  before { create(:tagging, tag: summer, taggable: black_tshirt) }

  describe "#results" do
    it "returns the input scope unchanged when params is empty" do
      result_empty = GarmentFilter.new(chris_scope, {}).results
      result_nil = GarmentFilter.new(chris_scope, nil).results

      expect(result_empty.pluck(:id).sort).to eq(chris_scope.pluck(:id).sort)
      expect(result_nil.pluck(:id).sort).to eq(chris_scope.pluck(:id).sort)
    end

    it "filters by color" do
      result = GarmentFilter.new(chris_scope, { color: "black" }).results

      expect(result).to include(black_tshirt)
      expect(result).not_to include(blue_jeans)
    end

    it "filters by category_id" do
      result = GarmentFilter.new(chris_scope, { category_id: top.id }).results

      expect(result).to include(black_tshirt)
      expect(result).not_to include(blue_jeans)
    end

    it "filters by tag_id (joins taggings and tags)" do
        result = GarmentFilter.new(chris_scope, { tag_id: summer.id }).results

        expect(result).to     include(black_tshirt)
        expect(result).not_to include(blue_jeans)
      end

    it "filters by brand" do
      result = GarmentFilter.new(chris_scope, { brand: "Levi's" }).results

      expect(result).to     include(blue_jeans)
      expect(result).not_to include(black_tshirt)
    end

    it "filters by color AND category_id combined" do
      result = GarmentFilter.new(chris_scope, { color: "black", category_id: top.id }).results

      expect(result).to     include(black_tshirt)
      expect(result).not_to include(blue_jeans)
    end

    it "filters by all 4 filters combined (color + category + tag + brand)" do
      result = GarmentFilter.new(
        chris_scope,
        { color: "black", category_id: top.id, tag_id: summer.id, brand: "Uniqlo" }
      ).results

      expect(result).to     include(black_tshirt)
      expect(result).not_to include(blue_jeans)
    end

    it "ignores unknown keys silently" do
      result = GarmentFilter.new(chris_scope, { color: "black", hacker: "DROP TABLE garments;" }).results

      expect(result).to     include(black_tshirt)
      expect(result).not_to include(blue_jeans)
    end

    it "ignores blank filter values" do
      result = GarmentFilter.new(chris_scope, { color: "" }).results

      expect(result.pluck(:id).sort).to eq(chris_scope.pluck(:id).sort)
    end

    it "never leaks records from other users even when filter matches" do
      result = GarmentFilter.new(chris_scope, { color: "black" }).results

      expect(result).to     include(black_tshirt)
      expect(result).not_to include(black_jacket)
    end

    it "filters by search with partial ILIKE match" do
      result = GarmentFilter.new(chris_scope, { search: "shirt" }).results

      expect(result).to     include(black_tshirt)
      expect(result).not_to include(blue_jeans)
    end

    it "filters by search and by color with AND" do
      result = GarmentFilter.new(chris_scope, { search: "jean", color: "blue" }).results

      expect(result).to     include(blue_jeans)
      expect(result).not_to include(black_tshirt)
    end

    it "escapes % wildcard in search to prevent matching everything" do
      result = GarmentFilter.new(chris_scope, { search: "%" }).results

      expect(result.pluck(:id).sort).not_to eq(chris_scope.pluck(:id).sort)
    end
  end
end
