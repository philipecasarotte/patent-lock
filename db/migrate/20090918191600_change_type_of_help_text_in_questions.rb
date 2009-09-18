class ChangeTypeOfHelpTextInQuestions < ActiveRecord::Migration
  def self.up
    change_column :questions, :help, :text
  end

  def self.down
    change_column :questions, :help, :string
  end
end
