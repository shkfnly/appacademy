class Contact < ActiveRecord::Base

  validates :email, :presence => true, :uniqueness => {:scope => :user_id}
  validates :name, :presence => true
  validates :user_id, :presence => true

  belongs_to(:owner,
             class_name: 'User',
             foreign_key: :user_id,
             primary_key: :id)

  has_many :contact_shares, dependent: :destroy
  has_many :shared_users, :through => :contact_shares, :source => :user
  has_many :comments, :as => :commentable
end
