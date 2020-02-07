class AddImpressionsCountToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :impressions_count, :integer, default: 0
  end
end
