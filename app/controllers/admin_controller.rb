class AdminController < ActionController::Base
  protect_from_forgery
  layout 'application'
  before_filter :logged_in_user
  before_filter :is_admin

  def is_admin
    unless @current_user.present? && @current_user.admin
      redirect_to group_index_path
    end
  end

  def logged_in_user
    @current_user = User.find(session[:user_id]) if session[:user_id].present?
  end

end
