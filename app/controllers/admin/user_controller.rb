class Admin::UserController < AdminController
  def index
    @users = User.all
  end
end