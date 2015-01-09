class UsersController < ApplicationController

  def new
    @user ||= User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user!(@user)
      redirect_to bands_url
    else
      flash.now[:notice] = "User not found"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def activate
    @user = @user.find_by(activation_token: params[:activation_token])
    @user.activated = true unless @user.nil?
    @user.save!
    log_in_user!(@user)
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end



end
