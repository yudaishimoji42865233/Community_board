class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :enquete
  
  validates_uniqueness_of :enquete_id, scope: :user_id
end
