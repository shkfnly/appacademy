class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :logged_in? 
  helper_method :log_in_user!


  def require_login

    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_session_url # halts request cycle
    end
  end
  
  def current_user
    return nil unless self.session[:session_token]
    @user ||= User.find_by(session_token: self.session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end


  def log_in_user!(user)
    user.reset_session_token!
    self.session[:session_token] = user.session_token
  end

  def log_out
    self.session[:session_token] = nil
  end
end
