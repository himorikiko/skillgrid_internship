class Product < ActiveRecord::Base
  strip_attributes
  paginates_per 15

  mount_uploader :image, ImageUploader

  validates :title, presence: true

  belongs_to :user

  scope :by_user, ->(user_id) { User.where(id: user_id).first.try(:products) }

  scope :pro, -> { where(pro: true ) }


  def set_pro
    self.pro = true
  end
end

