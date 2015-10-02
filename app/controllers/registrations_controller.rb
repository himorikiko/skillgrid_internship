class RegistrationsController < Devise::RegistrationsController
  def new_user
    @user = FormUser.new
  end

  def new_administrator
    @user = FormAdministrator.new
  end

  def new_shop
    @user = FormShop.new
  end

  def create
    byebug
    super
  end

end
