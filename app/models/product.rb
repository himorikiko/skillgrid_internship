class Product < ActiveRecord::Base
  strip_attributes
  paginates_per 15

  validates :title, presence: true

  belongs_to :user

  scope :by_user, ->(user_id) { User.where(id: user_id).first.try(:products) }

  mount_uploader :image, ImageUploader
end

