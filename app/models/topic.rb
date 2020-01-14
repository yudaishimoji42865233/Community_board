class Topic < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  has_many :comments, dependent: :destroy
  has_many :enquetes, dependent: :destroy
  accepts_nested_attributes_for :enquetes

  mount_uploader :image, ImageUploader
end
