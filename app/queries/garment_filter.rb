class GarmentFilter
  FILTERS = %i[color category_id tag_id brand search].freeze

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

  def by_color(relation, value)
    relation.where(color: value)
  end

  def by_category_id(relation, value)
    relation.where(category_id: value)
  end

  def by_tag_id(relation, value)
    relation.joins(:tags).where(tags: { id: value })
  end

  def by_brand(relation, value)
    relation.where(brand: value)
  end

  def by_search(relation, value)
    escaped = ActiveRecord::Base.sanitize_sql_like(value)
    relation.where("name ILIKE ?", "%#{escaped}%")
  end
end
