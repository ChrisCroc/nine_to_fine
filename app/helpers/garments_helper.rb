module GarmentsHelper
  def pill_class(active)
    base = "inline-block px-3 py-1 text-sm rounded-full transition whitespace-nowrap"
    if active
      "#{base} bg-zinc-900 text-champagne font-semibold"
    else
      "#{base} bg-white/70 text-zinc-700 hover:bg-white"
    end
  end
end
