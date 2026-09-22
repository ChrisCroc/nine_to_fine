class ExploreController < ApplicationController
  def index
    @pagy, @outfits = pagy(:countless, Outfit.public_feed, limit: 12)
  end
end
