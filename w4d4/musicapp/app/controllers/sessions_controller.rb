class SessionsController < ApplicationController

def new
  @user = User.new
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
    flash.now
  end
end




end
