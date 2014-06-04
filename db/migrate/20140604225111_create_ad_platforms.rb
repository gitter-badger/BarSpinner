class CreateAdPlatforms < ActiveRecord::Migration
  def change
    create_table :ad_platforms do |t|
      t.integer :user_id
      t.string :name
      t.string :url

      t.timestamps
    end

    add_index :ad_platforms, :user_id
  end
end
