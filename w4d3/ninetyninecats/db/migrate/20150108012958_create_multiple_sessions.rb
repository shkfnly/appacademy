class CreateMultipleSessions < ActiveRecord::Migration
  def change
    create_table :multiple_sessions do |t|
      t.integer :user_id, null: false
      t.string :session_token, null: false

      t.timestamps null: false
    end
    add_index :multiple_sessions, :user_id
    add_index :multiple_sessions, :session_token, unique: true
  end
end
