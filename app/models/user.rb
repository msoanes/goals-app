class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :goals

  attr_reader :password

  after_initialize :ensure_session_token

  def self.find_by_credentials(params)
    user = User.find_by(username: params[:username])
    user && user.is_password?(params[:password]) ? user : nil
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = gen_token
    save
    session_token
  end

  def viewable_goals
    Goal.where("user_id = ? OR is_private = false", id)
  end

  private

  def ensure_session_token
    self.session_token ||= gen_token
  end

  def gen_token
    SecureRandom.urlsafe_base64
  end
end
