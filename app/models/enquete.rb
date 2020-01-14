class Enquete < ApplicationRecord
  belongs_to :topic, inverse_of: :enquetes
end
