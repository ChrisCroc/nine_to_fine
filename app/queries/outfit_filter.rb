class OutfitFilter
  FILTERS = %i[tag_ids garment_id].freeze

  def initialize(scope, params)
    @scope = scope
    @params = (params || {}).slice(*FILTERS)
  end

  def results
    FILTERS.inject(@scope) { |relation, key| apply(relation, key) }
  end

  private

  def apply(relation, key)
    value = @params[key]
    return relation if value.blank?
    send("by_#{key}", relation, value)
  end

  def by_tag_ids(relation, value)
    relation.tagged_with_all(value)
  end

  def by_garment_id(relation, value)
    relation.joins(:outfit_garments).where(outfit_garments: { garment_id: value })
  end
end
