class AddRecentBarIdToAdPlatforms < ActiveRecord::Migration
  def change
    add_column :ad_platforms, :recent_bar_id, :integer
  end
end
