module GarmentsHelper
  def pill_class(active)
    base = "inline-block px-3 py-1 text-sm rounded-full transition whitespace-nowrap"
    if active
      "#{base} bg-zinc-900 text-champagne font-semibold"
    else
      "#{base} bg-white/70 text-zinc-700 hover:bg-white"
    end
  end

  def garment_thumb_url(garment)
    return nil unless garment.photo.attached?

    url_for(garment.photo.variant(resize_to_limit: [ 120, 120 ], format: :webp))
  end
end
