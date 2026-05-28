class Tag < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tagged_garments, through: :taggings, source: :taggable, source_type: "Garment"
  has_many :tagged_outfits, through: :taggings, source: :taggable, source_type: "Outfit"

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { scope: :user_id, case_sensitive: false }
end
