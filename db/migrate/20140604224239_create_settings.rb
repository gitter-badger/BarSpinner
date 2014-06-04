class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :bar_id
      t.string :bar_color
      t.string :text_color
      t.string :link_color
      t.integer :max_impressions_count, default: 100

      t.timestamps
    end

    add_index :settings, :bar_id
  end
end
