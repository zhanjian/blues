class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :s_id
      t.string :title
      t.string :artist
      t.string :pic
      t.text :content
      t.integer :user_id
      t.integer :conments_count

      t.timestamps
    end
    add_index :songs, [:user_id, :created_at]
  end
end
