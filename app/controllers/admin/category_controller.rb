class Admin::CategoryController < AdminController
  def index
    @users = User.all
  end
end