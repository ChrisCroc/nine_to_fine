module Garments
  class AnalysesController < ApplicationController
    def create
      result = Ai::GarmentTagger.new(photo: params.require(:photo)).tag
      render json: result.to_h
    rescue Ai::GarmentTagger::Error
      render json: { error: "analysis_failed" }, status: :unprocessable_content
    end
  end
end
