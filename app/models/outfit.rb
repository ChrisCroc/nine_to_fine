class Outfit < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 200 }, uniqueness: { scope: :user_id, case_sensitive: false }
end
