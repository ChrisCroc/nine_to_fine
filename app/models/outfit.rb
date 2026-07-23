class Outfit < ApplicationRecord
  include Taggable

  belongs_to :user
  has_many :outfit_garments, dependent: :destroy
  has_many :garments, through: :outfit_garments
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy

  enum :visibility, { private: 0, public: 1 }, prefix: true

  validates :name, presence: true, length: { maximum: 200 }, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :garments, presence: true

  def like_of(user)
    return nil unless user
    likes.find_by(user: user)
  end

  def visible_to?(viewer)
    visibility_public? || user == viewer
  end
end
