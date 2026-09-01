class SuggestionsController < ApplicationController
  def create
    unless params[:context].present? || anchor_ids.any?
      return head :unprocessable_content
    end

    OutfitSuggestionJob.perform_later(
      user: current_user,
      context: params[:context],
      anchor_garment_ids: anchor_ids,
      exclude_garment_ids: exclude_ids
    )
    # create.tubro_stream.erb injects the modal + spinner. No redirect
  end

  private

  def anchor_ids
    Array(params[:anchor_garment_ids]).reject(&:blank?)
  end

  def exclude_ids
    Array(params[:exclude_garment_ids]).reject(&:blank?)
  end
end
