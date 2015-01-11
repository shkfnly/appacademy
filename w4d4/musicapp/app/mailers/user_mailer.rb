class UserMailer < ApplicationMailer
  default from: 'accounts@musicapp.com'

  def welcome_email(user)
    @user = user
    @url = '<%= new_session %>'
    mail(to: user.email, subject: 'Welcome to Music App')
  end
  
  def auth_email(user)
    @user = user
    @url = '/users/activate/?activation_token=' + user.activation_token.to_s
    mail(to: user.email, subject: 'Please confirm your email.')
  end
end
