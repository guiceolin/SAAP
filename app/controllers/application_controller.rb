class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_authentication

  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= (session[:user_id] && User.find(session[:user_id]))
  end

  def require_authentication
    redirect_to new_sessions_path unless current_user
  end

  def require_no_authentication
    redirect_to new_sessions_path if current_user
  end
end
