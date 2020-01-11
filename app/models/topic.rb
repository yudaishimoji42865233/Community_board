class Topic < ApplicationRecord
  # belongs_to :category
  has_many :enquetes
  has_many :comments
end
