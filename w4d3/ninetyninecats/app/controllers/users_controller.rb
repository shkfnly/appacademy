class UsersController < ApplicationController
  before_action :logged_in

  has_many :cats
  has_many :cat_rental_requests
  def new
    @user = User.new

    render :new
  end

  def create
    params[:user][:password_digest] = BCrypt::Password.create(params[:user][:password])
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to cats_url
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password_digest, :session_token )
  end
end
