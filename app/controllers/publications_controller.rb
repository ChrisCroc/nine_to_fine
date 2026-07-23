class PublicationsController < ApplicationController
  before_action :set_outfit

  def create
    @outfit.visibility_public!
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @outfit }
    end
  end

  def destroy
    @outfit.visibility_private!
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @outfit }
    end
  end

  private

  def set_outfit
    @outfit = current_user.outfits.find(params.expect(:outfit_id))
  end
end
