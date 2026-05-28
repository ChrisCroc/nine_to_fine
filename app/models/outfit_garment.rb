class OutfitGarment < ApplicationRecord
  belongs_to :outfit
  belongs_to :garment
  validates :garment_id, uniqueness: { scope: :outfit_id }
end
