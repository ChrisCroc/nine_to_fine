class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :outfit, counter_cache: :comments_count

  validates :body, presence: true, length: { maximum: 1000 }
end
