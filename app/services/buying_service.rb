class BuyingService
  def buy(user, product)
    user_check = check_user(user)
    return user_check if user_check.fail?

    product_check = check_product(product)
    return product_check if product_check.fail?

    get_photo_from_service = photo_from_service user
    return get_photo_from_service if get_photo_from_service.fail?

    get_post_from_service = post_from_service user
    return get_post_from_service if get_post_from_service.fail?

    successfull_buy(user, get_photo_from_service.result, get_post_from_service.result)
  end

  private

  def successfull_buy user, photo_url, post
    AdministratorMailer.successfull_buy(post).deliver_later
    UserMailer.successfull_buy(user, photo_url).deliver_later
    Response.new.success!
  end

  def photo_from_service user
    response = JsonPlaceholderService.get_photo(user)
    AdministratorMailer.buy_error(user.email).deliver_later if response.fail?
    response
  end

  def post_from_service user
    response = JsonPlaceholderService.get_post
    AdministratorMailer.buy_error(user.email).deliver_later if response.fail?
    response
  end

  def check_user user
    if user.can_buy?
      Response.new.success!
    else
      Response.new.fail! ['Sorry, you can\'t buy anything']
    end
  end

  def check_product product
    if product.sell_able?
      Response.new.success!
    else
      Response.new.fail! ['Sorry, you can\'t buy this product']
    end
  end
end
