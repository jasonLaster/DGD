class GroupController < ActionController::Base
  layout 'application'
  
  def index
    @categories = Category.includes(:groups).find(:all)
  end
  
  def show
    @group = Group.find(params[:id])
  end

end
