class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: :likes_count

  validates :user_id, uniqueness: { scope: %i[likeable_type likeable_id] }

  after_create_commit -> {
    broadcast_replace_to likeable,
                          target: ActionView::RecordIdentifier.dom_id(likeable, :likes_count),
                          partial: "outfits/likes_count",
                          locals: { outfit: likeable }
  }

  after_destroy_commit -> {
    broadcast_replace_to likeable,
                          target: ActionView::RecordIdentifier.dom_id(likeable, :likes_count),
                          partial: "outfits/likes_count",
                          locals: { outfit: likeable }
  }
end
