class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :garments, dependent: :destroy
  has_many :outfits, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_follows, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :active_follows, source: :followed
  has_many :passive_follows, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }

  def self.search_by_username(query)
    return none if query.blank?

    where("username ILIKE ?", "%#{sanitize_sql_like(query)}%").limit(10)
  end

  def following?(user)
    followed_users.exists?(user.id)
  end
end
