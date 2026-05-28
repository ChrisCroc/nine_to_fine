class Outfit < ApplicationRecord
  belongs_to :user
  has_many :outfit_garments, dependent: :destroy
  has_many :garments, through: :outfit_garments
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :name, presence: true, length: { maximum: 200 }, uniqueness: { scope: :user_id, case_sensitive: false }
end
