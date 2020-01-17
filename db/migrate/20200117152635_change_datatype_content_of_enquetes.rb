class ChangeDatatypeContentOfEnquetes < ActiveRecord::Migration[5.0]
  def change
    change_column :enquetes, :content, :string, null: false
  end
end
