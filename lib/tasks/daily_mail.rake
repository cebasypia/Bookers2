namespace :daily_mail do
  desc "登録者全員にメールを送る"
  task send_mail: :environment do
    DailyMailer.send_daily_mail_users
  end
end
