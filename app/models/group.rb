class Group < ActiveRecord::Base

  belongs_to :category
  has_many :descriptions

  has_many :group_execs
  has_many :users, :through => :group_execs
  
  def to_s
    name
  end
  
  def exec?(user)
    false #self.users.include?(user) 
  end
  
  def most_recent_page
    descriptions.order("created_at DESC").first
  end
  
  
  def self.recently_updated(num)
    Description.all.sort_by { |d| d.updated_at }.reverse.map { |d| Group.find(d.group_id) }.uniq.take(num)
  end
  
  def self.find_by_description_id(id)
    Group.find(Description.find(id).group_id)
  end
  
  def self.groups_with_pages
    d_hash = {}
    Description.all.each { |d| d_hash[d.group_id] = d }
    d_hash.values
  end

end
