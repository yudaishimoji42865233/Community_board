class CreateEnquetes < ActiveRecord::Migration[5.0]
  def change
    create_table :enquetes do |t|
      t.string   "content"
      t.integer   "topic_id"
      t.timestamps
    end
  end
end
