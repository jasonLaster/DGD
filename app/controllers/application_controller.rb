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
    if @current_user.blocked
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

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActionController::UnknownAction, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  private
  def render_404(exception)
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500(exception)
    @error = exception
    respond_to do |format|
      format.html { render template: 'errors/error_500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end

end
