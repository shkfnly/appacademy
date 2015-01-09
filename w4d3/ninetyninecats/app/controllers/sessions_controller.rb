
class SessionsController < ApplicationController
  skip_before_action :logged_in, only: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
    params[:user][:user_name],
    params[:user][:password]
    )
    unless @user.nil?
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end

end
