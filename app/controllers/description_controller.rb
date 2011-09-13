class DescriptionController < ApplicationController
  layout 'application'
  before_filter :load_group_hash
  
  def index
    @group = Group.includes(:descriptions).find(params[:group_id])
    @descriptions = @group.descriptions.order("created_at DESC")
  end
  
  def new
    @group = Group.find(params[:group_id])
    @description = @group.descriptions.order("created_at DESC").first
    @description = @description.description.gsub("\r\n","\r") if @description.try(:description)
  end
  
  def show
  end

  def update
  end
  
  def destroy
  end
  
  def create
    @group = Group.find(params[:group_id])
    @description = @group.descriptions.build(:description => params[:description], :user => @current_user).save
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
  def load_group_hash
    @group_hash = Group.all.map {|g| {:label => g.name, :value => g.name, :id => g.id}}
  end

end
