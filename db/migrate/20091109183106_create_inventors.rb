class CreateInventors < ActiveRecord::Migration
  def self.up
    create_table :inventors do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :citizenship
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :email
      t.integer :order_id

      t.timestamps
    end
  end

  def self.down
    drop_table :inventors
  end
end
