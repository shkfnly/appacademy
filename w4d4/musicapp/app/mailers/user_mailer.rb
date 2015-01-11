class UserMailer < ApplicationMailer
  default from: 'accounts@musicapp.com'

  def welcome_email(user)
    @user = user
    @url = '<%= new_session %>'
    mail(to: user.email, subject: 'Welcome to Music App')
  end
  
  def auth_email(user)
    @user = user
    @url =  activate_user_url(@user.activation_token, email: @user.email)
    mail(to: user.email, subject: 'Account Activation.')
  end
end
