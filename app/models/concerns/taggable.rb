module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable, dependent: :destroy
    has_many :tags, through: :taggings
    after_save :sync_tags
  end

  def tag_names=(value)
    @tag_names = value.to_s.split(",").map { |name| name.strip.downcase }.reject(&:blank?).uniq
  end

  def tag_names
    tags.map(&:name).join(", ")
  end

private

  def sync_tags
    return if @tag_names.nil?
    self.tags = @tag_names.map { |name| user.tags.find_or_create_by(name: name) }
  end
end
