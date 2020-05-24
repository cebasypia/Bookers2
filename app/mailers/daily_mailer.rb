class DailyMailer < ApplicationMailer
  def daily_mail(user)
    require "date"
    @time_now = DateTime.now
    @user = user
    mail to: @user.email, subject: 'Daily Mail'
  end

  def self.send_daily_mail_users
    users = User.all
    users.each do |user|
      DailyMailer.daily_mail(user).deliver_now
    end
  end
end
