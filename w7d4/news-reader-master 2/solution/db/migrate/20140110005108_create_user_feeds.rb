class CreateUserFeeds < ActiveRecord::Migration
  def change
    create_table :user_feeds do |t|
      t.integer :user_id
      t.integer :feed_id

      t.timestamps
    end
  end
end
