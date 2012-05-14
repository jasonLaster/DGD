class GroupController < ApplicationController
  layout 'application'
  before_filter :group, :except => [:index, :about, :markdown, :leaderboard]
  before_filter :group_exec, :only => [:edit]


  def index
        
    # selected group on search dropdown
    if params[:group_id].present?
      group = Group.find(params[:group_id])
      if group.present?
        redirect_to group_path(group)
      else
        redirect_to group_index_path
      end
      
    # search for group on dropdown
    elsif params[:search].present?
      @groups = Group.search(params[:search])
      # Unique search results
      if @groups.length == 1
        redirect_to group_path(@groups.first)
      # No search results
      elsif @groups.length == 0
        @primary_categories = Category.primary_categories
        @categories = @primary_categories.map {|cat| [cat, Category.sub_categories(cat)]}
        @categories.map! do |primary_category, sub_categories|
          sc = sub_categories.map {|sub_category| [sub_category, sub_category.groups.includes(:descriptions)]}
          [primary_category, sc]
        end
        @categories.sort_by! {|p, c| p}
      # Nothing special to do if many search results
      end

    # show one categories groups
    elsif params[:category].present?
      @category = Category.find(params[:category])
      @sub_categories = Category.sub_categories(@category.primary_category)
      @sub_categories.map! {|sub_category| [sub_category, sub_category.groups.includes(:descriptions)]}
      
    # show the directory
    else
      @primary_categories = Category.primary_categories
      @categories = @primary_categories.map {|cat| [cat, Category.sub_categories(cat)]}
      @categories.map! do |primary_category, sub_categories|
        sc = sub_categories.map {|sub_category| [sub_category, sub_category.groups.includes(:descriptions)]}
        [primary_category, sc]
      end
      @categories.sort_by! {|p, c| p}
    end
    
    # other stuff
    @leaderboard = Description.leaderboard
    
  end
  
  def show
    @description = @group.descriptions.order("created_at DESC").first
    @user_flag = Flag.find_by_description_id_and_user_id(@description, @current_user)
    @flag_count = Flag.find_all_by_description_id(@description).count
    @group_exec = GroupExec.find_by_group_id_and_user_id(@group, @current_user)
    
    # Hide email addresses if user isn't logged in
    if !@description.nil?
      @clean_description = Nokogiri::HTML::DocumentFragment.parse(@description.markdown)
      links = @clean_description.at_css "a"
      if links
        if links['href'].try(:include?, "mailto:")
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
    @leaderboard = Description.leaderboard
  end
  
  def recently_updated
  end
  
  def least_updated
  end
  
  # GET /about
  def about
    @number_of_groups_with_pages = Description.total_count
  end
  
  # GET /markdown
  def markdown
  end

  private
  
  def group
    @group = Group.includes(:descriptions).find(params[:id])
  end
  
end

