class WelcomeMailer < ApplicationMailer
  default from: 'noreply@odinfacebook.com'
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to OdinFacebook!')
  end

end
