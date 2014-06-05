class AddAdPlatformIdToBars < ActiveRecord::Migration
  def change
    add_column :bars, :ad_platform_id, :integer
    add_index :bars, :ad_platform_id
  end
end
