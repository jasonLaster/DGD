class Category < ActiveRecord::Base

  validates :category, :presence => true, :uniqueness => true
  
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
  
  def self.groups(category)
    Group.includes(:category).where("categories.category LIKE ?", "%#{category}%")
  end
  
  
  def num_pages
    groups = self.groups.includes(:descriptions)
    groups.map {|g| g.descriptions.length}.sum
  end
  
  def self.num_added_pages
    descriptions = Description.includes(:group => :category)
    descriptions.group_by {|d| d.group.category}.map do |category, ds|
      num_descriptions = ds.group_by(&:group).keys.length
      {category => num_descriptions}
    end
  end

end
