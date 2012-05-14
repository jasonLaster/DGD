class Flag < ActiveRecord::Base
  belongs_to :user
  belongs_to :description
  
  
  def self.flags
    Flag.includes(:description =>:group).includes(:user)
  end
  
  def self.by_group
    Flag.flags.order("groups.name")
  end
  
  def self.group(group)
    Flag.by_group.where("groups.id is ?", group.id)
  end
  
end
