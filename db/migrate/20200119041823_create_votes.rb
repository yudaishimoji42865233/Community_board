class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :enquete, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
