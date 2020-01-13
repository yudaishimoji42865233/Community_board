class Comment < ApplicationRecord
  belongs_to :topic, dependent: :destroy

  mount_uploader :image, ImageUploader
end
