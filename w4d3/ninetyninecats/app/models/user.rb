
class User < ActiveRecord::Base

validates :user_name, :password_digest, :session_token, :presence => true
validates :session_token, :uniqueness => true

after_initialize :ensure_session_token

has_many :cats

has_many :multiple_sessions, :dependent => :destroy

has_many :cat_rental_requests

def reset_session_token!
  m = MultipleSession.where("session_token = ?", self.session_token)
  unless m.nil?
    MultipleSession.delete(m)
  end
  self.session_token = SecureRandom.urlsafe_base64
  self.save!
  MultipleSession.create(user_id: self.id, session_token: self.session_token)
end

def password=(password)
  @password = password
  password_digest = BCrypt::Password.create(@password)
end

def is_password?(password)
  BCrypt::Password.new(password_digest).is_password?(password)
end

def self.find_by_credentials(user_name, password)
  @user = User.find_by(user_name: user_name)
  return nil if @user.nil?
  @user.is_password?(password) ? @user : nil
end

private
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
    MultipleSession.create(user_id: self.id, session_token: self.session_token)
  end


end
