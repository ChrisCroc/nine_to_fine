require "rails_helper"

RSpec.describe NavigationHelper, type: :helper do
  describe "#nav_destinations" do
    it "returns the three signed_in destinations in order with their paths" do
      user = create(:user)
      allow(helper).to receive(:current_user).and_return(user)

      destinations = helper.nav_destinations

      expect(destinations.map { |d| d[:label] }).to eq(%w[Closet Looks Profile])
      expect(destinations.map { |d| d[:path] }).to eq([ garments_path, outfits_path, user_path(user) ])
    end
  end

  describe "#nav_active?" do
    it "is true when the current controller matches" do
      allow(helper).to receive(:controller_name).and_return("garments")

      expect(helper.nav_active?("garments")).to be true
    end

    it "is false when the current controller doesn't match" do
      allow(helper).to receive(:controller_name).and_return("outfits")

      expect(helper.nav_active?("garments")).to be false
    end
  end
end
