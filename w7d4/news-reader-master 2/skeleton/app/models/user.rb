class User < ActiveRecord::Base

  attr_reader :password

  validates :username, presence: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_validation :ensure_session_token

  has_many :feeds, :dependent => :destroy

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return user if user && user.is_password?(password)
    return nil
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save!
    session_token
  end

  private
    def ensure_session_token
      self.session_token || self.reset_session_token
    end
end
