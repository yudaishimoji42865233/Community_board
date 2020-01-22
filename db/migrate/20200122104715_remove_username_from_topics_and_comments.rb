class RemoveUsernameFromTopicsAndComments < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :username, :string
    remove_column :topics, :username, :string
  end
end
