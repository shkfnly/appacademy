class User < ActiveRecord::Base
  include Commentable
  
  attr_reader :password

  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :username, :session_token, uniqueness: true

  has_many :goals

  after_initialize :ensure_session_token


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end


  def self.find_by_credentials(username, password)
    @user = User.find_by_username(username)
    return nil unless @user && @user.is_password?(password)
    @user
  end

  def generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save
    self.session_token
  end

  private
    def ensure_session_token
      self.session_token ||= generate_session_token
    end

end
