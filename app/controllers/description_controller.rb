class DescriptionController < ActionController::Base
  layout 'application'
  
  def index
    @group = Group.includes(:descriptions).find(params[:group_id])
    @descriptions = @group.descriptions
  end
  
  def new
    @group = Group.find(params[:group_id])
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
  
  def create
    @group = Group.find(params[:group_id])
    @descriptions = @group.descriptions.build(:description => params[:description])
    @descriptions.save
    redirect_to @group
  end
  
  # GET group/:group_id/description/:id/flag
  def flag
    @group = Group.find(params[:group_id])
    @flag = Flag.new :user_id => session[:user_id], :description_id => params[:description_id]
    @flag.save
    redirect_to @group
  end

end
