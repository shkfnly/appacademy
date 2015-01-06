class User < ActiveRecord::Base
  validates :username, :uniqueness => true, :presence => true

  has_many(:contacts, class_name: 'Contact', foreign_key: :user_id, primary_key: :id)
  has_many(:contact_shares)
  has_many :shared_contacts, :through => :contact_shares, :source => :user
  has_many :comments, :as => :commentable
end
