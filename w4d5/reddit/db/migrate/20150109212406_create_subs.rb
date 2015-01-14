class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.string :description
      t.integer :moderator_id, null: false

      t.timestamps null: false
    end
  end
end
