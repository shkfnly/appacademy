class ApplicationController < ActionController::Base
  protect_from_forgery

  def log_in(user)
    user.reset_session_token
    session[:session_token] = user.session_token
    @current_user = user
  end

  def logged_in?
    @user = User.new
    render :json => @user if current_user.nil?
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end

end
