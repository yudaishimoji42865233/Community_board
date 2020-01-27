class Topic < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  has_many :comments, dependent: :destroy
  has_many :enquetes, dependent: :destroy
  has_many :topic_likes, dependent: :destroy
  belongs_to :user

  ransacker :topic_likes_count do
    query = '(SELECT COUNT(topic_likes.topic_id) FROM topic_likes where topic_likes.topic_id = topics.id GROUP BY topic_likes.topic_id)'
    Arel.sql(query)
  end
  
  accepts_nested_attributes_for :enquetes
  is_impressionable counter_cache: true
  mount_uploader :image, ImageUploader
end
