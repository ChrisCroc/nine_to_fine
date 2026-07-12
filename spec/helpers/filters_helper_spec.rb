require "rails_helper"

RSpec.describe FiltersHelper, type: :helper do
  describe "#garments_filter_count" do
    it "counts only active garment dimensions and ignores search" do
      params = { color: "black", category_id: "3", brand: "", tag_id: nil, search: "shirt" }

      expect(helper.garments_filter_count(params)).to eq(2)
    end

    it "is zero when nothing is active" do
      expect(helper.garments_filter_count({})).to eq(0)
    end
  end

  describe "#outfits_filter_count" do
    it "counts non-blank tag_ids plus one when a piece is set" do
      params = { tag_ids: [ "1", "2", "" ], garment_id: "7" }
      
      expect(helper.outfits_filter_count(params)).to eq(3)
    end
  end
end
