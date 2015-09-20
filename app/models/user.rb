class User < ActiveRecord::Base
  strip_attributes collapse_spaces: true, only: [:name]
  strip_attributes except: [:name, :password, :password_confirmation, :password_digest]

  has_secure_password

  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 50 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }
  validates :password, :password_confirmation, presence: true
end
