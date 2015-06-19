# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#  session_token   :string(255)      not null
#

class User < ActiveRecord::Base
  attr_reader :password
  validates :username, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}
  after_initialize :ensure_session_token

  has_many :subs,
    class_name: "Sub",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :moderator

  has_many :authored_posts,
    class_name: "Post",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy,
    inverse_of: :author

  has_many :comments,
    dependent: :destroy
    inverse_of: :author


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)
    return nil if @user.nil?
    @user.is_password?(password) ? @user : nil
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
end
