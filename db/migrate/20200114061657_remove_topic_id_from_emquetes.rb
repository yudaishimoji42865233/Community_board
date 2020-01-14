class RemoveTopicIdFromEmquetes < ActiveRecord::Migration[5.0]
  def change
    remove_column :enquetes, :topic_id, :integer
  end
end
