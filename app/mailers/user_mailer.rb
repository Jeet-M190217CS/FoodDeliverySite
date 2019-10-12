class UserMailer < ApplicationMailer
default from: "pawan_m190599cs@nitc.ac.in"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.order_confirmation.subject
  #
  def order_confirmation(user)
    @greeting = "Hi"
    @user=user
    mail to: user.email, subject: "Order confirmation" 
  end
end
