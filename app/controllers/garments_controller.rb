class GarmentsController < ApplicationController
  before_action :set_garment, only: %i[show edit update destroy]
  before_action :set_categories, only: %i[new edit create update]
  def index
    @garments = current_user.garments.includes(:category, photo_attachment: :blob).order(created_at: :desc)
  end

  def show
  end

  def new
    @garment = current_user.garments.new
  end

  def create
    @garment = current_user.garments.new(garment_params)

    if @garment.save
      redirect_to @garment, notice: "Garment was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @garment.update(garment_params)
      redirect_to @garment, status: :see_other, notice: "Garment was successfully updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @garment.destroy
    redirect_to garments_path, status: :see_other, notice: "Garment was successfully deleted."
  end

private

  def set_garment
    @garment = current_user.garments.find(params.expect(:id))
  end

  def garment_params
    permitted = params.expect(garment: [ :name, :color, :description, :brand, :category_id, :photo, :tag_names ])
    permitted.delete(:photo) if permitted[:photo].blank?
    permitted
  end

  def set_categories
    @categories = Category.order(:position)
  end
end
