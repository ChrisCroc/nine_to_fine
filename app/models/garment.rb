class Garment < ApplicationRecord
  include Taggable

  belongs_to :user
  belongs_to :category
  has_many :outfit_garments, dependent: :destroy
  has_many :outfits, through: :outfit_garments
  has_one_attached :photo

  COLORS = %w[black white grey beige brown red orange yellow green purple blue pink cream].freeze

  validates :name, presence: true, length: { maximum: 200 }
  validates :color, presence: true, inclusion: { in: COLORS, allow_blank: true }
  validates :photo,
            content_type: { in: %w[image/png image/jpeg image/webp image/heic image/heif], spoofing_protection: true },
            size: { less_than: 10.megabytes, message: "must be smaller than 10MB" }
end
