class Product < ActiveRecord::Base
  strip_attributes
  paginates_per 15

  mount_uploader :image, ImageUploader

  validates :title, presence: true

  belongs_to :user

  scope :by_user, ->(user_id) { User.where(id: user_id).first.try(:products) }

  scope :pro, -> { where(pro: true ) }

  before_save :fill_shop_name


  def set_pro
    self.pro = true
  end

  def fill_shop_name
    self.shop_title = self.user.shop_title
  end

  def sell_able?
    !(self.shop_title.blank? || self.pro)
  end
end

