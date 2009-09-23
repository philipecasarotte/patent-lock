class AddSummaryTextToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :summary, :string
  end

  def self.down
    remove_column :pages, :summary
  end
end
