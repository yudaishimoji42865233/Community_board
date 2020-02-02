class CommentLike < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :comment_id, :user_id, presence: true
  
  validates_uniqueness_of :comment_id, scope: :user_id
end
