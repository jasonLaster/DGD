class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :logged_in_user
  before_filter :exceptional_info
  
  def logged_in_user
    @current_user = User.find(session[:user_id]) if session[:user_id].present?
  end
  
  def is_logged_in
    unless logged_in_user.present?
      redirect_to group_index_path
    end
  end
  
  def blocked_user
    if logged_in_user.present? && logged_in_user.blocked
      redirect_to root_path
    end
  end
  
  def group_exec
    unless @group.group_execs.any? {|e| e.user == @current_user} || @current_user.admin
      redirect_to group_path(@group)
    end
  end
  
  def exceptional_info
    params = {}
    params.merge!({:user_id => @current_user.id, :name => @current_user.name, :email => @current_user.email}) if @current_user.present? 
    Exceptional.context(params)
  end
  
end
