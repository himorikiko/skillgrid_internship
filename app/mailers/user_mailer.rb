class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def successfull_buy(user, photo)
    @user = user
    @url = photo
    mail(to: @user.email, subject: 'You successfully buy product')
  end

end
