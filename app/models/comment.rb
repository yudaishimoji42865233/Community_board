class Comment < ApplicationRecord
  belongs_to :topic, dependent: :destroy
  belongs_to :user
  has_many :comment_likes, dependent: :destroy

  validates :content, :topic_id, :user_id, presence: true

  mount_uploader :image, ImageUploader
end
