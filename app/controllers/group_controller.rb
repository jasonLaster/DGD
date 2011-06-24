class GroupController < ActionController::Base
  layout 'application'
  
  def index
    @categories = Category.includes(:groups).find(:all)
    
    # sort the categories and groups
    @categories.sort_by!(&:category)
    @categories.each {|c| c.groups.sort_by!(&:name)}
    
  end
  
  def show
    @group = Group.includes(:descriptions).find(params[:id])
    @description = @group.descriptions.order("created_at DESC").first
    if (!@description.presence)
      @description = Description.new
      @description.description = Description.default_description
    end
  end
  
  def leaderboard
  end
  
  def recently_updated
  end
  
  def least_updated
  end
end
