class SuggestionsController < ApplicationController
  def create
    unless suggestion_params[:context].present? || anchor_ids.any?
      return render :blank_request, status: :unprocessable_content
    end

    OutfitSuggestionJob.perform_later(
      user: current_user,
      context: suggestion_params[:context],
      anchor_garment_ids: anchor_ids,
      exclude_garment_ids: exclude_ids,
      coordinates: coordinates
    )
    # create.turbo_stream.erb injects the modal + spinner. No redirect
  end

  private

  def suggestion_params
    @suggestion_params ||= params.permit(:context, :latitude, :longitude,
                                          anchor_garment_ids: [], exclude_garment_ids: [])
  end

  def anchor_ids
    Array(suggestion_params[:anchor_garment_ids]).reject(&:blank?)
  end

  def exclude_ids
    Array(suggestion_params[:exclude_garment_ids]).reject(&:blank?)
  end

  # Either a usable pair or nothing at all: a latitude without a longitude is
  # unusable, so the half-filled state dies here instead of being re-checked
  # at every step downstream.
  # /!\ Float(..., exception: false), never to_f: "abc".to_f is 0.0, and 0.0/0.0
  # is a real spot in the Gulf of Guinea the weather API answers for happily.
  def coordinates
    latitude = Float(suggestion_params[:latitude], exception: false)
    longitude = Float(suggestion_params[:longitude], exception: false)
    return unless latitude&.between?(-90, 90) && longitude&.between?(-180, 180)

    [ latitude, longitude ]
  end
end
