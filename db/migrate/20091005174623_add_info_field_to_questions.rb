class AddInfoFieldToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :info, :string
  end

  def self.down
    remove_column :questions, :info
  end
end
