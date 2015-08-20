class CreatePokemons < ActiveRecord::Migration
  def change
    create_table :pokemons do |t|
      t.string :name, null: false
      t.integer :attack, null: false
      t.integer :defense, null: false
      t.string :poke_type, null: false
      t.string :moves, null: false
      t.string :image_url, null: false

      t.timestamps
    end
  end
end
