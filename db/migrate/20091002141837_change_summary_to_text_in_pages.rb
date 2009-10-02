class ChangeSummaryToTextInPages < ActiveRecord::Migration
  def self.up
    change_column :pages, :summary, :text
  end

  def self.down
    change_column :pages, :summary, :string
  end
end
