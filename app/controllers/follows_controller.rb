class FollowsController < ApplicationController
  before_action :set_user

  def create
    current_user.active_follows.find_or_create_by(followed: @user)
    respond_with_button
  end

  def destroy
    current_user.active_follows.find_by(followed: @user)&.destroy
    respond_with_button
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def respond_with_button
    @user.reload
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          helpers.dom_id(@user, :follow),
          partial: "users/follow_button",
          locals: { user: @user }
        )
      }
      format.html { redirect_to user_path(@user) }
    end
  end
end
