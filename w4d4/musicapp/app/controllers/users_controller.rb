class UsersController < ApplicationController

  def new
    @user ||= User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      msg = UserMailer.auth_email(@user)
      msg.deliver_now
      redirect_to root_url
      flash[:info] = "Please check your email to activate the account"
    else
      flash.now[:danger] = "Invalid User Parameters"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def activate
    # if @user && @user.authenticated?(:activation, params[:id])
    @user = User.find_by(activation_token: params[:id])
    @user.activated = true unless @user.nil?
    @user.save
    log_in_user!(@user)
    redirect_to albums_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end



end
