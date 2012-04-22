class DescriptionController < ApplicationController
  layout 'application'
  before_filter :blocked_user, :only => [:create, :flag]
  
  def index
    @group = Group.includes(:descriptions).find(params[:group_id])
    @descriptions = @group.descriptions.order("created_at DESC")
  end
  
  def new
    @group = Group.find(params[:group_id])
    @description = @group.most_recent_page ||
    @new_description = @group.descriptions.build
    
    unless @description.nil? || @description.new_record?
      @description.description.gsub("\r\n","\r") 
      @new_description.description = @description.description
    end
    
  end
  
  def show
  end

  def update
    @group = Group.find(params[:group_id])
    @description = @group.most_recent_page.dup
    @description.update_attributes(params[:description])
    render :partial => "description/checklist_form"
  end
  
  def destroy
  end
  
  def create
    @group = Group.find(params[:group_id])
    @description = @group.most_recent_page
    new_description = params[:description][:description]

    if @description && @description.description == new_description
      @description.dup.update_attributes(:description => new_description, :user_id => @current_user.id) 
    else
      @group.descriptions.build(:description => new_description, :user_id => @current_user.id).save
    end

    redirect_to @group
  end
  
  # GET group/:group_id/description/:id/flag
  def flag
    @group = Group.find(params[:group_id])
    @description = Description.find(params[:description_id])
    @flag = Flag.find_by_description_id_and_user_id(@description, @current_user)

    if @flag.present?
      @flag.destroy
    else
      Flag.new(:user_id => @current_user, :description_id => params[:description_id]).save
    end

    redirect_to @group
  end
  
  private
end
