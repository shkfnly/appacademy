class SessionsController < ApplicationController

  before_action :redirect_if_logged_in, only: [:create, :new]

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user.nil?
      flash.now[:errors] = "Invalid username or password"
      render :new
    else
      log_in!(@user)
      redirect_to user_url(@user)
    end
  end

  def new
    @user = User.new
  end

  def destroy
    session[:session_token] = nil
    @user = User.new
    render :new
  end

  private

  def redirect_if_logged_in
    redirect_to user_url(current_user) unless current_user.nil?
  end


end
