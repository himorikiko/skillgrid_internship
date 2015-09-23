class AdministratorMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def successfull_buy(post_id)
    email_list = User.where(role_id: Role.with_name(:administrator)).pluck(:email)
    @post_id = post_id
    mail(to: email_list, subject: 'User successfully buy product')
  end

  def buy_error(user_email)
    email_list = User.where(role_id: Role.with_name(:administrator)).pluck(:email)
    @user_email = user_email
    mail(to: email_list, subject: 'Smth went wrong')
  end

end
