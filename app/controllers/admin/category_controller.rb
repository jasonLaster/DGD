class Admin::CategoryController < AdminController
  def index
    @categories = Category.all
  end
end