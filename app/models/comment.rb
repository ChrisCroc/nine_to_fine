class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :outfit, counter_cache: :comments_count

  validates :body, presence: true, length: { maximum: 1000 }

  after_create_commit -> {
    broadcast_prepend_to outfit,
    target: ActionView::RecordIdentifier.dom_id(outfit, :comments),
    partial: "comments/comment", locals: { comment: self }
  broadcast_replace_to outfit,
    target: ActionView::RecordIdentifier.dom_id(outfit, :comments_count),
    partial: "comments/comments_count", locals: { outfit: outfit }
  }

  after_destroy_commit -> {
    broadcast_remove_to outfit
    broadcast_replace_to outfit,
      target: ActionView::RecordIdentifier.dom_id(outfit, :comments_count),
      partial: "comments/comments_count", locals: { outfit: outfit }
  }
end
