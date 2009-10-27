class CreateDrawings < ActiveRecord::Migration
  def self.up
    create_table :drawings do |t|
      t.integer :order_id
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.datetime :image_updated_at
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :drawings
  end
end
