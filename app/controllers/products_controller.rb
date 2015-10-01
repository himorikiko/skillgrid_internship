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
      flash[:alert] = "Sorry, _you_ cant buy _anything_"
    else
      if !@product.sell_able?
        flash[:alert] = "Sorry, we can't sell _this_ product"
      else

        j_p_service = JsonPlaceholderService.new
        photo_url = j_p_service.get_photo
        if photo_url.nil?
          flash[:alert] =  "Sorry, _you_ can't buy this product. Try again later"
        else
          post = j_p_service.get_post(photo_url)

          flash[:notice] = "You successfully buy a product"
          redirect_to(:back)
        end
      end
    end
    redirect_to :back
  rescue Timeout::Error
    flash[:alert] = "Sorry, timeout error"
    redirect_to :back
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
