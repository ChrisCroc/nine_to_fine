class Garment < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :outfit_garments, dependent: :destroy
  has_many :outfits, through: :outfit_garments
  validates :name, presence: true, length: { maximum: 200 }
  validates :color, presence: true
end
