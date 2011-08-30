class GroupController < ApplicationController
  layout 'application'
  before_filter :load_group_hash
  
  def index
    
    # search functionality
    if params[:group_id] && Group.exists?(params[:group_id])
      redirect_to group_path(Group.find(params[:group_id]))
    end
    
    @categories = Category.includes(:groups).find(:all)
    
    # sort the categories and groups
    @categories.sort_by!(&:category)
    @categories.each {|c| c.groups.sort_by!(&:name)}
    
    @categories_hash = {}
    @categories_hash[:coso] = Category.includes(:groups).find_by_category("COSO Organizations")
    @categories_hash[:mens_sports] = Category.includes(:groups).find_by_category("Men's Varsity Sports")
    @categories_hash[:womens_sports] = Category.includes(:groups).find_by_category("Women's Varsity Sports")
    @categories_hash[:intramurals] = Category.includes(:groups).find_by_category("Intramurals")
    @categories_hash[:fraternity] = Category.includes(:groups).find_by_category("Fraternity")
    @categories_hash[:sorority] = Category.includes(:groups).find_by_category("Sorority")
    @categories_hash[:co_ed] = Category.includes(:groups).find_by_category("Co-Ed")
    @categories_hash[:mens_sports] = Category.includes(:groups).find_by_category("Men's Varsity Sports")
    @categories_hash[:womens_sports] = Category.includes(:groups).find_by_category("Women's Varsity Sports")
    @categories_hash[:intramurals] = Category.includes(:groups).find_by_category("Intramurals")
    @categories_hash[:tf] = Category.includes(:groups).find_by_category("Tucker - Faith Programs")
    @categories_hash[:tr] = Category.includes(:groups).find_by_category("Tucker - Religious Groups")
    @categories_hash[:ti] = Category.includes(:groups).find_by_category("Tucker - International Service")
    @categories_hash[:tl] = Category.includes(:groups).find_by_category("Tucker - Local Service")
    @categories_hash[:di] = Category.includes(:groups).find_by_category("Dickey Center")
    @categories_hash[:go] = Category.includes(:groups).find_by_category("Governing Organizations")
    @categories_hash[:rc] = Category.includes(:groups).find_by_category("Rockefeller Center")
    
  end
  
  def show
    @group = Group.includes(:descriptions).find(params[:id])
    @description = @group.descriptions.order("created_at DESC").first
    @flag = Flag.find_by_description_id_and_user_id(@description, @current_user)
    @flag_count = Flag.find_all_by_description_id(@description).count
    
    if @description.nil?
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
  
  private
  def load_group_hash
    @group_hash = Group.all.map {|g| {:label => g.name, :value => g.name, :id => g.id}}
  end
end

