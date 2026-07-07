require "rails_helper"

RSpec.describe OutfitFilter do
  let(:chris) { create(:user) }
  let(:john)  { create(:user) }

  let(:summer) { create(:tag, name: "summer", user: chris) }
  let(:chic)   { create(:tag, name: "chic", user: chris) }

  let(:shirt) { create(:garment, user: chris, name: "White shirt") }

  let!(:summer_chic) { create(:outfit, user: chris) }
  let!(:summer_only) { create(:outfit, user: chris) }
  let!(:with_shirt)  { create(:outfit, user: chris) }

  let(:chris_scope) { chris.outfits }

  before do
    create(:tagging, tag: summer, taggable: summer_chic)
    create(:tagging, tag: chic, taggable: summer_chic)
    create(:tagging, tag: summer, taggable: summer_only)
    with_shirt.garments << shirt
  end

  describe "#results" do
    it "returns the scope unchanged when params is empty" do
      expect(OutfitFilter.new(chris_scope, {}).results.pluck(:id).sort)
        .to eq(chris_scope.pluck(:id).sort)
    end

    it "filters by a single tag id" do
      result = OutfitFilter.new(chris_scope, { tag_ids: [ summer.id ] }).results

      expect(result).to include(summer_chic, summer_only)
    end

    it "filters by several tags with AND" do
      result = OutfitFilter.new(chris_scope, { tag_ids: [ summer.id, chic.id ] }).results

      expect(result).to include(summer_chic)
      expect(result).not_to include(summer_only)
    end

    it "filters by garment_id (outfit containing that piece)" do
      result = OutfitFilter.new(chris_scope, { garment_id: shirt.id }).results

      expect(result).to include(with_shirt)
      expect(result).not_to include(summer_only)
    end

    it "ignores blank values" do
      result = OutfitFilter.new(chris_scope, { tag_ids: [] }).results

      expect(result.pluck(:id).sort).to eq(chris_scope.pluck(:id).sort)
    end

    it "never leaks another user's outfits" do
      john_outfit = create(:outfit, user: john)
      result = OutfitFilter.new(chris_scope, { tag_ids: [ summer.id ] }).results

      expect(result).not_to include(john_outfit)
    end
  end
end
