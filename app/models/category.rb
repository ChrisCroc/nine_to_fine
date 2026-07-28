class Category < ApplicationRecord
  belongs_to :parent, class_name: "Category", optional: true
  has_many :subcategories, -> { order(:position) },
            class_name: "Category", foreign_key: :parent_id, dependent: :restrict_with_error
  has_many :garments, dependent: :restrict_with_error
  scope :parents, -> { where(parent_id: nil).order(:position) }
  scope :leaves, -> { where.not(parent_id: nil) }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :position, presence: true, numericality: { only_integer: true }
  validate :parent_must_be_top_level

  private

  def parent_must_be_top_level
    return if parent.nil?

    errors.add(:parent, "must be a top-level category") if parent.parent_id.present?
  end
end
