class ProductsController < ApplicationController
  before_action :signed_in_user, only: [:new, :edit, :update]
  before_action :find_product, only: [:show, :edit]

  def new
    @product = Product.new
  end

  def index
    if params[:user]
      @product = Product.by_user(params[:user]).paginate(page: params[:page], per_page: 12)
    else
      @product = Product.paginate(page: params[:page], per_page: 12)
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      flash[:success] = "Added!"
      redirect_back_or @product
    else
      render 'new'
    end
  end

  private

    def find_product
        @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :image)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
end
