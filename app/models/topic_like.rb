class TopicLike < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  validates :topic_id, :user_id, presence: true
  
  validates_uniqueness_of :topic_id, scope: :user_id
end
