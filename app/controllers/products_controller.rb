class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :role_required
  inherit_resources

  def index
    if params[:user]
      @product = Product.by_user(params[:user]).page params[:page]
    else
      @product = Product.page params[:page]
    end
  end

  def create
    @product = current_user.products.build(product_params)
    create!
  end

  def buy
    @product = Product.find(params[:id])
    if !current_user.can_buy?
      alert_flash_and_back "Sorry, _you_ cant buy _anything_"
      return
    end

    if !@product.sell_able?
      alert_flash_and_back "Sorry, we can't sell _this_ product"
      return
    end

    j_p_service = JsonPlaceholderService.new

    begin
      photo_url = j_p_service.get_photo
    rescue Timeout::Error
      alert_flash_and_back "Sorry, timeout error"
      return
    end
    if photo_url.nil?
      AdministratorMailer.buy_error(current_user.email).deliver_later
      alert_flash_and_back "Sorry, _you_ can't buy this product. Try again later"
      return
    else
      begin
        post = j_p_service.get_post
      rescue Timeout::Error
        alert_flash_and_back "Sorry, timeout error"
        return
      end
      AdministratorMailer.successfull_buy(post).deliver_later
      UserMailer.successfull_buy(current_user, photo_url).deliver_later
      flash[:notice] = "You successfully buy a product"
      redirect_to(:back)
    end

  end

  private

    def alert_flash_and_back message
      flash[:alert] = message
      redirect_to :back
    end

    def product_params
      permitted_keys = []

      if current_user.has_role?(:products, :set_pro)
        permitted_keys.push(:pro)
      else
        permitted_keys.push(:title, :description, :image)
      end

      params.require(:product).permit(permitted_keys)
    end

end
