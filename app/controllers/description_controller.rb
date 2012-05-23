class DescriptionController < ApplicationController
  layout 'application'
  before_filter :blocked_user, :only => [:create, :flag]
  before_filter :is_logged_in, :only => [:checklist, :create]

  def index
    @group = Group.includes(:descriptions).find(params[:group_id])
    @descriptions = @group.descriptions.order("created_at DESC")
  end

  def new
    @group = Group.find(params[:group_id])
    @description = @group.most_recent_page
    @new_description = @group.descriptions.build

    unless @description.nil?
      @description.description.try {|d| d.gsub("\r\n","\r") }
      @new_description.description = @description.description
    end

    # Prevents sneaky people from editing locked pages
    if @group.locked
      redirect_to group_path(@group)
    end

  end

  def show
  end

  def destroy
  end

  def checklist
    @group = Group.find(params[:group_id])
    @old_description = @group.most_recent_page

    if @old_description.present?
      @description = @old_description
      @description.update_attributes(params[:description])
    else
      @description = @group.descriptions.build(params[:description])
      @description.user = @current_user
      @description.save
    end

    render :partial => "description/checklist_form"
  end

  def create
    @group = Group.find(params[:group_id])
    @old_description = @group.most_recent_page
    new_description = params[:description][:description]

    if @old_description.present?
      unless @old_description.description == new_description
        @old_description.dup.update_attributes(:description => new_description, :user_id => @current_user.id)
      end
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
