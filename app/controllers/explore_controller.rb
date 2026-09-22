class ExploreController < ApplicationController
  def index
    @pagy, @outfits = pagy(:countless, Outfit.public_feed, limit: 12)

    # The batch template is never reachable by content negotiation: after a
    # sign-in Turbo follows the redirect to "/" still asking for a Turbo Stream,
    # and a template named after the action would be served to a page that has
    # no target to append to. It is only rendered for a real "load more" click.
    render :batch if request.format.turbo_stream? && params[:page].present?
  end
end
