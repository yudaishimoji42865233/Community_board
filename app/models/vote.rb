class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :enquete

  validates :enquete_id, :user_id, presence: true
  
  validates_uniqueness_of :enquete_id, scope: :user_id
end
