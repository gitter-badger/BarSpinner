class CreateImpressions < ActiveRecord::Migration
  def change
    create_table :impressions do |t|
      t.integer :bar_id
      t.datetime :created_at
      t.string :type
    end

    add_index :impressions, :bar_id 
  end
end
