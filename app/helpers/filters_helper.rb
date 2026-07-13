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

  def filter_pill_class
    "inline-block px-3 py-1 text-sm rounded-full whitespace-nowrap cursor-pointer " \
    "bg-white/70 text-zinc-700 hover:bg-white " \
    "peer-checked:bg-zinc-900 peer-checked:hover:bg-zinc-900 peer-checked:text-champagne peer-checked:font-semibold"
  end
end
