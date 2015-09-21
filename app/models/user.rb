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

  validates :role_id, presence: true

  validates :avatar, presence: true, if: Proc.new { |a| a.role == Role.with_name(:shop) || a.role == Role.with_name(:admin) }

  validates :password, length: { minimum: 10 },if: Proc.new { |a| a.role == Role.with_name(:admin) }
  validates :name, :last_name, :passport_photo, :birth_date, presence: true, if: Proc.new { |a| a.role == Role.with_name(:admin) }

  validates :shop_title, presence: true, if: Proc.new { |a| a.role == Role.with_name(:shop) }
  validates :password, length: { minimum: 8 }, if: Proc.new { |a| a.role == Role.with_name(:shop) }

  validates :password, length: { minimum: 6 }, if: Proc.new { |a| a.role == Role.with_name(:user) }

  has_many :products, dependent: :destroy

end
