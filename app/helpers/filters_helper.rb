module FiltersHelper
  GARMENT_FILTER_KEYS = %i[color category_id brand tag_id].freeze

  def garments_filter_count(params)
    params = params.to_h.with_indifferent_access
    GARMENT_FILTER_KEYS.count { |key| params[key].present? }
  end

  def outfits_filter_count(params)
    params = params.to_h.with_indifferent_access
    Array(params[:tag_ids]).count(&:present?) + (params[:garment_id].present? ? 1 : 0)
  end
end
