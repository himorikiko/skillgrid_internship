class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :role_required
  inherit_resources

  include HTTParty

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
    if current_user.can_buy? && current_user.has_role?(:products, :buy)
      if @product.sell_able?
        photo_url = get_photo
        if photo_url.nil?
          flash[:alert] = "Sorry, _you_ can't buy this product. Try again later"
          AdministratorMailer.buy_error(current_user.email).deliver_later
          redirect_to :back
        else
          post = HTTParty.post("http://jsonplaceholder.typicode.com/todos")
          post_id = post['id']
          AdministratorMailer.successfull_buy(post_id).deliver_later
          UserMailer.successfull_buy(current_user, photo_url).deliver_later
          redirect_to(:back)
        end
      else
        flash[:alert] = "Sorry, we can't sell _this_ product"
        redirect_to :back
      end
    else
      flash[:alert] = "Sorry, _you_ cant buy _anything_"
      redirect_to(:back)
    end
  end

  private

    def product_params
      permitted_keys = []

      if current_user.has_role?(:products, :set_pro)
        permitted_keys.push(:pro)
      else
        permitted_keys.push(:title, :description, :image)
      end

      params.require(:product).permit(permitted_keys)
    end


  def get_photo
    get = HTTParty.get("http://jsonplaceholder.typicode.com/photos/#{Random.rand(42..4242)}")
    image = JSON.parse(get.body)
    if image['url'].split("/").last.to_i(16) > image['thumbnailUrl'].split("/").last.to_i
      image['url']
    else
      nil
    end
  end

end
