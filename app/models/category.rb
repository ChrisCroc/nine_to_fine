class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :position, presence: true, numericality: { only_integer: true }
end
