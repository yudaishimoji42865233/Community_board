class RemoveTopicIdFromComments < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :topic_id, :integer
  end
end
