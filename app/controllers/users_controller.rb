class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :require_self, only: %i[edit update]
  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profile updated"
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_self
    redirect_to user_path(@user), alert: "You can only edit your own profile." unless @user == current_user
  end

  def user_params
    params.expect(user: [ :username ])
  end
end
