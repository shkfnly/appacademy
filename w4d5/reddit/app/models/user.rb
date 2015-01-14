class User < ActiveRecord::Base

  attr_reader :password

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :subs, foreign_key: :moderator_id
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id

  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def reset_session_token
    self.session_token = User.generate_session_token
    self.save!
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
