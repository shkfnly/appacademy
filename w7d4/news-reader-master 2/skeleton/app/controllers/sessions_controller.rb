class SessionsController < ApplicationController

  def new
    @user = User.new
    render :json => @user
  end

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user
      log_in(@user)
      render :json => @user
    else
      render :json => {:error => "Invalid username/password"}, status: :unproccesable_entity
    end
  end

  def destroy
    session[:session_token] = nil
    User.reset_session_token
    redirect_to new_session_url
  end

end
