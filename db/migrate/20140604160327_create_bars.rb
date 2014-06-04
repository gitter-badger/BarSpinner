class CreateBars < ActiveRecord::Migration
  def change
    create_table :bars do |t|
      t.integer :user_id
      t.string :name
      t.string :token
      t.string :message
      t.string :link_text
      t.string :link_url

      t.timestamps
    end

    add_index :bars, :user_id
    add_index :bars, :token
  end
end
