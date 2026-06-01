class OutfitsController < ApplicationController
  before_action :set_outfit, only: %i[show edit update destroy]
  before_action :set_garments, only: %i[new edit create update]

  def index
    @outfits = current_user.outfits.includes(:garments).order(created_at: :desc)
  end

  def show
  end

  def new
    @outfit = current_user.outfits.new
  end

  def create
    @outfit = current_user.outfits.new(outfit_params)
    if @outfit.save
      redirect_to @outfit, notice: "Outfit successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @outfit.update(outfit_params)
      redirect_to @outfit, status: :see_other, notice: "Outfit successfully updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @outfit.destroy
    redirect_to outfits_path, status: :see_other, notice: "Outfit successfully deleted."
  end

private
  def set_outfit
    @outfit = current_user.outfits.find(params.expect(:id))
  end

  def outfit_params
    params.expect(outfit: [ :name, :description, garment_ids: [] ])
  end

  def set_garments
    @garments = current_user.garments.order(created_at: :desc)
  end
end
