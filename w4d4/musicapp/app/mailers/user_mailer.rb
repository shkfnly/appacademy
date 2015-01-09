class UserMailer < ApplicationMailer
  default from: 'accounts@musicapp.com'

  def welcome_email(user)
    @user = user
    @url = '<%= new_session %>'
    mail(to: user.email, subject: 'Welcome to Music App')
  end
  
  def authentication_email(user)
    @user = user
    @url = '/users/activate/?activation_token=<%= user.activation_token %>'
  end
end
