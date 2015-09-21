class ProductsController < ApplicationController
  before_action :authenticate_user!
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

  private

    def product_params
      params.require(:product).permit(:title, :description, :image)
    end

end
