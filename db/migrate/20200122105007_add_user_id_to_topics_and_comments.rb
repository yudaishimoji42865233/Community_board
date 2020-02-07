class AddUserIdToTopicsAndComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :topics, :user, null: false, foreign_key: true
    add_reference :comments, :user, null: false, foreign_key: true
  end
end
