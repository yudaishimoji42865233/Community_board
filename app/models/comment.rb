class Comment < ApplicationRecord
  belongs_to :topic, dependent: :destroy
  belongs_to :user

  mount_uploader :image, ImageUploader
end
