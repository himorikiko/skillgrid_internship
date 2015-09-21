class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :role_required
  inherit_resources

  def index
    if params[:user]
      @product = Product.by_user(params[:user]).page params[:page]
    else
      if current_user.has_role?(:products, :only_pro)
        @product = Product.pro.page params[:page]
      else
        @product = Product.page params[:page]
      end
    end
  end

  def show
    if current_user.has_role?(:products, :only_pro)
      @product = Product.pro.find_by(params[:id])
    end
    super
  end

  def create
    @product = current_user.products.build(product_params)
    create!
  end

  private

    def product_params
      permitted_keys = []

      permitted_keys.push(:pro) if current_user.has_role?(:products, :set_pro)
      permitted_keys.push(:title, :description, :image) if current_user.admin?

      params.require(:product).permit(permitted_keys)
    end

end
