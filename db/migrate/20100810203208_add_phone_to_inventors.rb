class AddPhoneToInventors < ActiveRecord::Migration
  def self.up
    add_column :inventors, :phone, :string
  end

  def self.down
    remove_column :inventors, :phone
  end
end