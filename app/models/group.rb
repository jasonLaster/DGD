class Group < ActiveRecord::Base

  belongs_to :category
  has_many :descriptions
  
  def to_s
    name
  end

end
