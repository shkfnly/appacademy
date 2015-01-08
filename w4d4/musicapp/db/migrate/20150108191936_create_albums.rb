class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :band_id, null: false
      t.string :style, null: false

      t.timestamps null: false
    end
    add_index :albums, :band_id
    add_index :albums, :title
  end
end
