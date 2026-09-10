class SuggestionsController < ApplicationController
  def create
    unless suggestion_params[:context].present? || anchor_ids.any?
      return render :blank_request, status: :unprocessable_content
    end

    OutfitSuggestionJob.perform_later(
      user: current_user,
      context: suggestion_params[:context],
      anchor_garment_ids: anchor_ids,
      exclude_garment_ids: exclude_ids
    )
    # create.turbo_stream.erb injects the modal + spinner. No redirect
  end

  private

  def suggestion_params
    params.permit(:context, anchor_garment_ids: [], exclude_garment_ids: [])
  end

  def anchor_ids
    Array(suggestion_params[:anchor_garment_ids]).reject(&:blank?)
  end

  def exclude_ids
    Array(suggestion_params[:exclude_garment_ids]).reject(&:blank?)
  end
end
