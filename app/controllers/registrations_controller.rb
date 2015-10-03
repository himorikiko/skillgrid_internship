class RegistrationsController < Devise::RegistrationsController
  def new
    role = Role.with_name(params[:role].to_sym)
    if !role.nil?
      if role.name == 'guest'
        @user = FormGuest.new
        render template: '/devise/registrations/new_guest'
      elsif role.name == 'shop'
        @user = FormShop.new
        render template: '/devise/registrations/new_shop'
      elsif role.name = 'administrator'
        @user = FormAdministrator.new
        render template: '/devise/registrations/new_administrator'
      end
    else
      redirect_to root_url
    end
  end

  def create
    # byebug
    role = Role.find(params[:user]['role_id'])
    if !role.nil?
      if role.name == 'guest'
        @user = FormGuest.new(form_guest_params)
        if @user.valid?
          @user = User.create(form_guest_params)
          user_created = true
        else
          render template: '/devise/registrations/new_guest'
        end
      elsif role.name == 'shop'
        @user = FormShop.new(form_shop_params)
        if @user.valid?
          @user = User.create(form_shop_params)
          user_created = true
        else
          render template: '/devise/registrations/new_shop'
        end
      elsif role.name = 'administrator'
        @user = FormAdministrator.new(form_administrator_params)
        if @user.valid?
          @user = User.create(form_administrator_params)
          user_created = true
        else
          render template: '/devise/registrations/new_administrator', :locals => { role: 'administrator'}
        end
      end
    else
      redirect_to root_url
    end

    if user_created
      set_flash_message :notice, :signed_up if is_flashing_format?
      sign_up(:user, @user)
      respond_with @user, location: after_sign_up_path_for(@user)
    end
  end

  private

    def form_guest_params
      params.require(:user).permit(:email, :password_confirmation, :password, :role_id)
    end

    def form_shop_params
      params.require(:user).permit(:email, :password_confirmation, :password, :avatar,
                                   :avatar_cache, :shop_name, :role_id)
    end

    def form_administrator_params
      params.require(:user).permit(:email, :password_confirmation, :password, :avatar,
                                   :avatar_cache, :name, :last_name, :birth_date, :passport_photo,
                                   :passport_photo_cache, :role_id)
    end
end
