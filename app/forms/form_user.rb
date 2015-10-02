class FormUser
  include ActiveModel::Model
  include Virtus.model

  attr_accessor :role_id

  attribute :email, String
  attribute :password, String
  attribute :password_confirmation, String
  attribute :role_id, Integer

  validates :password, :password_confirmation, :email, presence: true
  validates :password, length: { minimum: 6 }
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
