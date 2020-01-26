class Topic < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  has_many :comments, dependent: :destroy
  has_many :enquetes, dependent: :destroy
  has_many :topic_likes, dependent: :destroy
  belongs_to :user
  
  accepts_nested_attributes_for :enquetes
  is_impressionable counter_cache: true
  mount_uploader :image, ImageUploader
end
