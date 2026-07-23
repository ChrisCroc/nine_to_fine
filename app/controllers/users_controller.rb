class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_user, only: %i[show edit update]
  before_action :require_self, only: %i[edit update]

  def index
    @query = params[:query]
    @users = User.search_by_username(@query)
    render :index, layout: false
  end

  def show
    @outfits = @user.outfits.visibility_public
                    .includes(garments: [ :category, { photo_attachment: :blob } ])
                    .order(created_at: :desc)
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
