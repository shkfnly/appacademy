class Comment < ActiveRecord::Base
  validates :author_id, :body, :commentable_id, :commentable_type, presence: true

  belongs_to :author, class_name: 'User'

  belongs_to :commentable, polymorphic: true
end
