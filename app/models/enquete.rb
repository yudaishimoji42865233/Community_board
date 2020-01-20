class Enquete < ApplicationRecord
  belongs_to :topic
  has_many :votes
end
