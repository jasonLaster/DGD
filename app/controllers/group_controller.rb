class GroupController < ApplicationController
  layout 'application'
  before_filter :group, :except => [:index]
  before_filter :group_exec, :only => [:edit]


  def index
    
    # search functionality
    if params[:group_id] && Group.exists?(params[:group_id])
      redirect_to group_path(Group.find(params[:group_id]))
    elsif params[:search] && group =  Group.where("name LIKE ?", "%#{params[:search]}%").first
      redirect_to group_path(group)
    end
    
    
    if params[:category].present?
      @category = Category.find(params[:category])
      @sub_categories = Category.sub_categories(@category.primary_category)
      @sub_categories.map! {|sub_category| [sub_category, sub_category.groups]}
    else
      @primary_categories = Category.primary_categories
      @categories = @primary_categories.map {|cat| [cat, Category.sub_categories(cat)]}
      @categories.map! do |primary_category, sub_categories|
        sc = sub_categories.map {|sub_category| [sub_category, sub_category.groups]}
        [primary_category, sc]
      end
      @categories.sort_by! {|p, c| p}
    end
  end
  
  def show
    @description = @group.descriptions.order("created_at DESC").first
    @user_flag = Flag.find_by_description_id_and_user_id(@description, @current_user)
    @flag_count = Flag.find_all_by_description_id(@description).count
    
    # Hide email addresses if user isn't logged in
    if !@description.nil?
      @clean_description = Nokogiri::HTML::DocumentFragment.parse(@description.markdown)
      links = @clean_description.at_css "a"
      if links
        if links['href'].include? "mailto:"
          links['href'] = "/auth/cas"
          links.content = "<login to see email address>"
        end
      end
      @clean_description = @clean_description.to_html.html_safe
    else
      @description = Description.new
      @description.description = Description.default_description
      @clean_description = @description
    end
  end

  def edit
    @description = @group.descriptions.order("created_at DESC").first
  end
  
  def leaderboard
  end
  
  def recently_updated
  end
  
  def least_updated
  end
  
  private
  
  def group
    @group = Group.includes(:descriptions).find(params[:id])
  end
  
end

