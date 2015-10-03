class FormShop
  include ActiveModel::Model
  include Virtus.model

  attribute :email, String
  attribute :password, String
  attribute :password_confirmation, String
  attribute :avatar, String
  attribute :avatar_cache, String
  attribute :shop_title, String
  attribute :role_id, Integer


  validates :password, :password_confirmation, :email, :avatar, :shop_name,
            presence: true

  validates :password, length: { minimum: 8 }
  validates_format_of :email, :with  => Devise.email_regexp

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    @user = User.create!(email: email, password: password, password_confirmation: password_confirmation)
  end

end
