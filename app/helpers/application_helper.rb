module ApplicationHelper

  def page_title
    controller = params[:controller]
    action = params[:action]

    if controller == "group" && action == "index" then "DGD - Directory"
    elsif controller == "group" && action == "show" then "DGD - #{@group.name}"
    else "DGD"
    end
    
  end

  def current_user  
    if session[:user_id]  
      @current_user ||= User.find(session[:user_id]) 
    end
  end  

  def anonymous_name
    session[:anonymous_name] ||= "anonymous-#{(rand*1000).ceil}"
  end
  
  def navbar_class
    "dev-mode" if ENV["RAILS_ENV"] == "development"
  end
end
