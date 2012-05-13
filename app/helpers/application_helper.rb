module ApplicationHelper

  def page_title
    base_title = "DGD#{Rails.env.development? ? " (dev)" : ""}"
    controller = params[:controller]
    action = params[:action]

    if controller == "group" && action == "index" then "#{base_title} - Directory"
    elsif controller == "group" && action == "show" then "#{base_title} - #{@group.name}"
    else "#{base_title}"
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
    "dev-mode" if Rails.env.development?
  end
end
