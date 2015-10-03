class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  include TheRole::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u|
          u.permit(:email, :password, :password_confirmation, :role_id, :name,
                   :last_name, :avatar, :avatar_cache, :passport_photo_cache,
                   :passport_photo, :birth_date, :shop_title ) }

      devise_parameter_sanitizer.for(:account_update) { |u|
          u.permit(:email, :password, :password_confirmation, :role_id, :name,
                   :last_name, :avatar, :avatar_cache, :passport_photo_cache,
                   :passport_photo, :birth_date, :shop_title ) }

    end
end
