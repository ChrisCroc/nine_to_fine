class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_outfit

  def create
    @like = current_user.likes.find_or_create_by(likeable: @outfit)

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          helpers.dom_id(@outfit, :like_button),
          partial: "outfits/like_button",
          locals: { outfit: @outfit }
        )
       }
      format.html { redirect_to @outfit }
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          helpers.dom_id(@outfit, :like_button),
          partial: "outfits/like_button",
          locals: { outfit: @outfit }
        )
      }
      format.html { redirect_to @outfit }
    end
  end

private

  def set_outfit
    @outfit = Outfit.find(params[:outfit_id])
  end
end
