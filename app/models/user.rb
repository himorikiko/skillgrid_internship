class User < ActiveRecord::Base
  strip_attributes collapse_spaces: true, only: [:name]
  strip_attributes except: [:name, :password, :password_confirmation, :password_digest]

  paginates_per 12

  has_secure_password

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  has_many :products, dependent: :destroy

  validates :name,  presence: true, length: { maximum: 50 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }
  validates :password, :password_confirmation, presence: true

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
