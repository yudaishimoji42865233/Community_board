class Topic < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  has_many :enquetes, dependent: :destroy
  has_many :comments, dependent: :destroy

  mount_uploader :image, ImageUploader
end
