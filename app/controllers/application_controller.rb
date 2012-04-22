class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :logged_in_user
  
  def logged_in_user
    @current_user = User.find(session[:user_id]) if session[:user_id].present?
  end
  
  def is_logged_in
    unless logged_in_user.present?
      redirect_to group_index_path
    end
  end
  
  def blocked_user
    if @current_user.blocked
      redirect_to root_path
    end
  end
  
  def group_exec
    unless @group.group_execs.any? {|e| e.user == @current_user} || @current_user.admin
      redirect_to group_path(@group)
    end
  end
end
