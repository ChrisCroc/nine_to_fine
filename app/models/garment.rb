class Garment < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :name, presence: true, length: { maximum: 200 }
  validates :color, presence: true
end
