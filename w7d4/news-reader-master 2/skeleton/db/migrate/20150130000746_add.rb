class Add < ActiveRecord::Migration
  def change
      add_column :feeds, :user_id, :string
  end
end
