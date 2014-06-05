class AddImpressionsCountToBars < ActiveRecord::Migration
  def change
    add_column :bars, :visits_count, :integer
    add_column :bars, :clicks_count, :integer
    remove_column :bars, :user_id
  end
end
