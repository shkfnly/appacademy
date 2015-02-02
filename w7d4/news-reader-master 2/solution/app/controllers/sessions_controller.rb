class SessionsController < ApplicationController
  def new
  end

  def create
    u = User.find_by_credentials(params[:user])
    if u
      login!(u)
      redirect_to "/"
    else
      redirect_to new_session_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
