class GroupController < ActionController::Base
  layout 'application'
  
  def index
    @categories = Category.includes(:groups).find(:all)
  end
  
  def show
    @group = Group.includes(:descriptions).find(params[:id])
    @description = @group.descriptions.order("created_at DESC").first
  end

end
