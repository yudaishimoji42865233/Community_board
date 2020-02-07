class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string   "content"
      t.string   "image"
      t.integer  "topic_id"
      t.string  "username"
      t.timestamps
    end
  end
end
