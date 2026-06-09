class Garment < ApplicationRecord
  include Taggable

  belongs_to :user
  belongs_to :category
  has_many :outfit_garments, dependent: :destroy
  has_many :outfits, through: :outfit_garments
  has_one_attached :photo

  COLORS = %w[black white grey beige brown red orange yellow green purple blue pink cream].freeze
  COLOR_HEX = {
    "black" => "000000",
    "white" => "ffffff",
    "grey" => "6b7280", # Tailwind gray-500
    "beige" => "d6c1a3", # custom (Tailwind has no natif beige)
    "brown" => "a16207", # Tailwind amber-700 (no native brown)
    "red" => "ef4444", # Tailwind red-500
    "orange" => "f97316", # Tailwind orange-500
    "yellow" => "eab308", # Tailwind yellow-500
    "green" => "22c55e", # Tailwind green-500
    "purple" => "a855f7", # Tailwind purple-500
    "blue" => "3b82f6", # Tailwind blue-500
    "pink" => "ec4899", # Tailwind pink-500
    "cream" => "f5f5dc" # cream HTML standard (Tailwind has no native cream)
}.freeze

  validates :name, presence: true, length: { maximum: 200 }
  validates :color, presence: true, inclusion: { in: COLORS, allow_blank: true }
  validates :photo,
            content_type: { in: %w[image/png image/jpeg image/webp image/heic image/heif], spoofing_protection: true },
            size: { less_than: 10.megabytes, message: "must be smaller than 10MB" }
end
