class Group < ActiveRecord::Base

  belongs_to :category
  has_many :descriptions
  
  def to_s
    name
  end
  
  def self.recently_updated(num)
    Description.all.sort_by { |d| d.updated_at }.map { |d| d.group_id }.map { |id| Group.find(id) }.uniq.take(num)
  end
  
  def self.find_by_description_id(id)
    Group.find(Description.find(id).group_id)
  end

end
