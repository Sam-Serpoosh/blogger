class AddViewedCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :viewed_count, :integer, default: 0
  end
end
