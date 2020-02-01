class RemoveUniqueToModelName < ActiveRecord::Migration[5.0]
  def up
    remove_index :users, :image
    add_index :users, :image
  end

  def down
    remove_index :users, :image
    add_index :users, :image, unique: true
  end
end
