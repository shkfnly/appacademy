class Comment < ActiveRecord::Base
  validates :content, :author_id, :post_id, presence: true

  belongs_to :author, class_name: 'User'
  belongs_to :post
end
