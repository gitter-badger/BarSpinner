class AddTokenToAdPlatform < ActiveRecord::Migration
  def change
    add_column :ad_platforms, :token, :string
    remove_column :bars, :token
  end
end
