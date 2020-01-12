class Topic < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  has_many :enquetes
  has_many :comments

end
