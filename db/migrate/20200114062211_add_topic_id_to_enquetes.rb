class AddTopicIdToEnquetes < ActiveRecord::Migration[5.0]
  def change
    add_reference :enquetes, :topic, null: false, foreign_key: true
  end
end
