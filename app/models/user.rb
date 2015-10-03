class User < ActiveRecord::Base
  include TheRole::Api::User

  mount_uploader :avatar, AvatarUploader
  mount_uploader :passport_photo, PassportUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  paginates_per 12

  strip_attributes

  # validates :role_id, presence: true

  # validates :avatar, presence: true, if: "role == Role.with_name(:shop) || role == Role.with_name(:administrator)"

  # validates :password, length: { minimum: 10 },if: "role == Role.with_name(:administrator)"
  # validates :name, :last_name, :passport_photo, :birth_date, presence: true, if: "role == Role.with_name(:administrator)"

  # validates :shop_title, presence: true, if: "role == Role.with_name(:shop)"
  # validates :password, length: { minimum: 8 }, if: "role == Role.with_name(:shop)"

  # validates :password, length: { minimum: 6 }, if: "role == Role.with_name(:guest)"

  has_many :products, dependent: :destroy

  def can_buy?
    if self.email =~ /\.com$/ && current_user.has_role?(:products, :buy)
      false
    else
      true
    end
  end

end
