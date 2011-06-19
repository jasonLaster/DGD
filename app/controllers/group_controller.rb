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
    empty_text = File.open("public/empty_group_page.txt").read 
    @markdown = Redcarpet.new(@description.presence ? @description.description : empty_text).to_html.html_safe    
  end
end
