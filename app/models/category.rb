class Category < ActiveRecord::Base

  has_many :groups

  def primary_category
    self.category.split("/").first
  end
  
  def sub_category
    self.category.split("/").second 
  end
  
  def self.sub_categories(category)
    category += "%"
    Category.where("category LIKE ?", category)
  end
  
  def self.primary_categories
    Category.select("category").map(&:category).map {|c| c.split("/").first.try(:strip)}.uniq
  end

end
