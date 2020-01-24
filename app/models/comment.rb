class Comment < ApplicationRecord
  belongs_to :topic, dependent: :destroy
  belongs_to :user
  has_many :comment_likes, dependent: :destroy

  mount_uploader :image, ImageUploader
end
