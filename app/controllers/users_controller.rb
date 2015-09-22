class UsersController < ApplicationController
  inherit_resources

  def index
    @users = User.order(:name).page params[:page]
  end

end
