class GroupController < ActionController::Base
  layout 'application'
  
  def index
    @categories = Category.find(:all)
    @groups = Group.find(:all)
  end
  
  def show
    @group = Group.find(params[:id])
  end

end
