class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.decimal :service_price, :precision => 8, :scale => 2, :default => 0
      t.boolean :questionnaire_on_hold, :default => 0
      t.text :away_message

      t.timestamps
    end
  end

  def self.down
    drop_table :configurations
  end
end
