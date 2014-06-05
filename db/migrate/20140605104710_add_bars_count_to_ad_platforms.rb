class AddBarsCountToAdPlatforms < ActiveRecord::Migration
  def change
    add_column :ad_platforms, :bars_count, :integer, default: 0
  end
end
