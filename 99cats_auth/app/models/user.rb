class User < ApplicationRecord
  validates :password_digest, presence: true
  validates :session_token, :username, presence: true, uniqueness: true
  validates :password, length: {minimum: 3, allow_nil: true}

  after_initialize :ensure_session_token

  attr_reader :password

  has_many :cats
  has_many :cat_rental_requests #

  def ensure_session_token
    self.session_token ||= Secu3reRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    save
    self.session_token
  end

  def password=(new_pass)
    @password = new_pass
    self.password_digest = BCrypt::Password.create(new_pass)
  end

  def is_password?(pass)
    BCrypt::Password.new(self.password_digest)
      .is_password?(pass)
  end

  def self.find_by_credentials(user_name, pass)
    user = User.find_by(username: user_name)
    return nil unless user
    user.is_password?(pass) ? user : nil
  end

  # def owns(cat)
  #   cats.
  # end
end
