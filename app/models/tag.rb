class Tag < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { scope: :user_id, case_sensitive: false }
end
