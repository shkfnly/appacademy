class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    return nil if self.session[:session_token].nil?
    if MultipleSession.find_by(session_token: self.session[:session_token])
      @user = MultipleSession.find_by(session_token: self.session[:session_token]).user
    else
      @user ||= User.find_by(session_token: self.session[:session_token])
    end
  end

  def login_user!(user)
    user.reset_session_token!
    self.session[:session_token] = user.session_token
  end

  def logged_in
    unless current_user.nil?
      redirect_to cats_url
    end
  end

  def log_out!
    m = MultipleSession.find_by(session_token: self.session[:session_token])
    m.delete
    self.session[:session_token] = nil

  end
end
