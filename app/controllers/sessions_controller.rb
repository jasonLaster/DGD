class SessionsController < ApplicationController

  def open_sesame
    session[:user_id] = 1
    redirect_to root_path
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_name(auth["extra"]["name"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    reset_session
    app = 'DGD'
    url = 'http://localhost:3000'
    redirect_to "https://login.dartmouth.edu/logout.php?app=#{app}&url=#{url}"
  end

end
