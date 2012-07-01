class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    user = User.find_by_email(auth['uid'].split.join(".").gsub('..', '.')) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    reset_session
    app = 'DGD'
    url = 'http://dgd.dartmouth.edu/'
    redirect_to "https://login.dartmouth.edu/logout.php?app=#{app}&url=#{url}"
  end
end
