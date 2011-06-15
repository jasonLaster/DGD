class GroupController < ActionController::Base
  layout 'application'
  
  def index
    @groups = Group.find(:all)
  end
  
  def show
    @group = Group.find(params[:id])
  end

end
