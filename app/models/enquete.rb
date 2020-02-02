class Enquete < ApplicationRecord
  belongs_to :topic
  has_many :votes

  validates :content, :topic_id, presence: true
end
