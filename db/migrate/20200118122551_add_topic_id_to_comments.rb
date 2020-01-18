class AddTopicIdToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :topic, null: false, foreign_key: true
    change_column :comments, :content, :string, null: false
    change_column :topics, :category_id, :integer, null: false
  end
end
