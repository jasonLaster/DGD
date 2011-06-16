class DescriptionController < ActionController::Base
  layout 'application'
  
  def index
    @group = Group.includes(:descriptions).find(params[:group_id])
    @descriptions = @group.descriptions
  end
  
  def new
  end
  
  def edit
    @group = Group.includes(:descriptions).find(params[:group_id])
    @description = @group.descriptions.order("created_at DESC").first
  end

  def show
  end

  def update
  end
  
  def destroy
  end

end
