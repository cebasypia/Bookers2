class ThanksMailer < ApplicationMailer
  def account_registration(resource)
    @user = resource
    @greeting = "thanks!!"

    mail to: @user.email, subject: 'account registration is completed'
  end
end
