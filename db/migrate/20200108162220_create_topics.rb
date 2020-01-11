class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :username
      t.string :title,  null: false
      t.string :content,  null: false
      t.string :image
      t.integer :category_id
      t.timestamps
    end
  end
end
