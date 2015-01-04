class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :visitor_id
      t.integer :visited_url

      t.timestamps

    end
    add_index :visits, :visited_url
  end
end
