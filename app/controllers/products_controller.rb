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

    response = BuyingService.new.buy(current_user, @product)
    if response.success?
      flash[:notice] = "You successfully buy a product"
    else
      flash[:alert] = response.errors.map {|e| e}.join('. ')
    end
    redirect_to products_url
  end

  private

    def can_buy?
      if !current_user.can_buy?
        flash[:alert] = "Sorry, _you_ cant buy _anything_"
        false
      else
        if !@product.sell_able?
          flash[:alert] = "Sorry, we can't sell _this_ product"
          false
        else
          true
        end
      end
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
