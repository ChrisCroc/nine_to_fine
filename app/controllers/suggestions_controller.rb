class SuggestionsController < ApplicationController
  def create
    unless params[:context].present? || anchor_ids.any?
      return head :unprocessable_content
    end

    OutfitSuggestionJob.perform_later(
      user: current_user,
      context: params[:context],
      anchor_garment_ids: anchor_ids
    )
    # create.tubro_stream.erb injects the modal + spinner. No redirect
  end

  private

  def anchor_ids
    Array(params[:anchor_garment_ids]).reject(&:blank?)
  end
end
