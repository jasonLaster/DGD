class GroupController < ActionController::Base

  def index
    @groups = Group.find(:all)
  end
  
  def show
    @group = Group.find(params[:id])
  end
end
