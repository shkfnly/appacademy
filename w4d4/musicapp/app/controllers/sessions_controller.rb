class SessionsController < ApplicationController
  
def new
  @user ||= User.new
  render :new
end

def create 
  @user = User.find_by_credentials(
    params[:user][:email],
    params[:user][:password])
  unless @user.nil?
    log_in_user!(@user)
    redirect_to user_url(@user)
  else
    flash.now[:errors] = @user.errors.full_messages
    render :new
  end
end

def destroy
  log_out
  redirect_to bands_url
end




end
