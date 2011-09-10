class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :logged_in_user
  
  def logged_in_user
    @current_user = User.find(session[:user_id]) if session[:user_id].present?
  end
  
  def blocked_user
    if @current_user.blocked
      redirect_to root_path
    end
  end
end
