class User < ActiveRecord::Base
validates :email, :session_token, :presence => true
validates :email, :session_token, :uniqueness => true
validates :password_digest, presence: { message: "Password can't be blank"}

after_initialize :ensure_session_token
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
  end

  private

  

    def ensure_session_token
      self.session_token ||= generate_session_token
    end
end