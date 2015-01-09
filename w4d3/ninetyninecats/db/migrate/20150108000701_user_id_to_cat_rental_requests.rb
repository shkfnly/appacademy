class UserIdToCatRentalRequests < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :user_id, :integer
  end
end
