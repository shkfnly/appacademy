class MultipleSession < ActiveRecord::Base

  validates :user_id, :session_token, presence: true
  validates :session_token, uniqueness: true

  belongs_to :user
end
