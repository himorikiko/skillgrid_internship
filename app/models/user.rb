class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  X = 6
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable, password_length: X..128

  strip_attributes

  paginates_per 12


  before_save { self.email = email.downcase }

  has_many :products, dependent: :destroy

  def full_name
    (name.to_s + ' ' +last_name.to_s).strip
  end
end
