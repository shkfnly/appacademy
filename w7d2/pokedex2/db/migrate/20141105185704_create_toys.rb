class CreateToys < ActiveRecord::Migration
  def change
    create_table :toys do |t|
      t.integer :pokemon_id, null: false
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :happiness, null: false
      t.string :image_url, null: false

      t.timestamps
    end

    add_index :toys, :pokemon_id
  end
end
