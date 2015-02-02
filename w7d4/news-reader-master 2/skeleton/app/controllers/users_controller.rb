class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      render :json => @user
    else
      render :json => {:error => "Invalid username/password"}, status: :unproccesable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to new_session_url
  end

end
