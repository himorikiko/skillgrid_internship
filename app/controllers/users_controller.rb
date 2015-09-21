class UsersController < ApplicationController
  inherit_resources

  def index
    @users = User.order(:name).page params[:page]
  end

  private

    def user_params
      params.require(:user).permit(
        :name,
        :last_name
      )
    end

end
