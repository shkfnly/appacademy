class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      render :show
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

end
