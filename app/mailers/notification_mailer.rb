class NotificationMailer < ApplicationMailer
  default from: 'letsechat@gmail.com'
 
  def welcome_email
    email = "kishanptl.kp@gmail.com"
    @url  = 'http://example.com/login'
    mail(to: email, subject: "Welcome to Let's Echat")
  end
end
