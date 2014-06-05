class FixCounterCache < ActiveRecord::Migration
  def change
    change_column :bars, :visits_count, :integer, default: 0
    change_column :bars, :clicks_count, :integer, default: 0
    change_column :settings, :bar_color, :string, default: '#EB583C'
    change_column :settings, :text_color, :string, default: '#000000'
    change_column :settings, :link_color, :string, default: '#000000'
  end
end
