class AddPricesToConfigurations < ActiveRecord::Migration
  def self.up
    add_column :configurations, :patent_search_price, :decimal, :precision => 8, :scale => 2, :default => 0
    add_column :configurations, :trademark_application_price, :decimal, :precision => 8, :scale => 2, :default => 0
    add_column :configurations, :trademark_search_price, :decimal, :precision => 8, :scale => 2, :default => 0
    add_column :configurations, :combo_patent_price, :decimal, :precision => 8, :scale => 2, :default => 0
  end

  def self.down
    remove_column :configurations, :patent_search_price
    remove_column :configurations, :trademark_application_price
    remove_column :configurations, :trademark_search_price
    remove_column :configurations, :combo_patent_price    
  end
end
