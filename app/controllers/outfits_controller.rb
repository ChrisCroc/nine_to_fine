class OutfitsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_outfit, only: %i[edit update destroy]
  before_action :set_garments, only: %i[new edit create update]

  def index
    base = current_user.outfits.includes(garments: [ :category, { photo_attachment: :blob } ])
    @filter_params = filter_params
    @outfits = OutfitFilter.new(base, @filter_params).results.order(created_at: :desc)

    @available_tags = current_user.tags.joins(:taggings).where(taggings: { taggable_type: "Outfit" }).distinct.order(:name)
    @filter_garment = current_user.garments.find_by(id: @filter_params[:garment_id])
  end

  def show
    @outfit = Outfit.includes(garments: [ :category, { photo_attachment: :blob } ], comments: :user).find(params.expect(:id))
    raise ActiveRecord::RecordNotFound unless @outfit.visible_to?(current_user)
  end

  def new
    @outfit = current_user.outfits.new(name: params[:name])
    @outfit.garment_ids = owned_garment_ids(params[:garment_ids]) if params[:garment_ids].present?
  end

  def create
    @outfit = current_user.outfits.new(outfit_params.except(:garment_ids))
    @outfit.garment_ids = owned_garment_ids(outfit_params[:garment_ids])
    if @outfit.save
      redirect_to @outfit, notice: "Outfit successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    @outfit.assign_attributes(outfit_params.except(:garment_ids))
    @outfit.garment_ids = owned_garment_ids(outfit_params[:garment_ids]) if outfit_params[:garment_ids].present?
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
    params.expect(outfit: [ :name, :description, :tag_names, garment_ids: [] ])
  end

  def set_garments
    @garments = current_user.garments.includes(photo_attachment: :blob).order(created_at: :desc)
  end

  def owned_garment_ids(ids)
    current_user.garments.where(id: Array(ids).reject(&:blank?)).ids
  end

  def filter_params
    params[:q]&.permit(:garment_id, tag_ids: []) || {}
  end
end
