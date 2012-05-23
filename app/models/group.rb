class Group < ActiveRecord::Base

  belongs_to :category
  has_many :descriptions

  has_many :group_execs
  has_many :users, :through => :group_execs

  validates :name, :presence => true, :uniqueness => true

  def to_s
    name
  end

  def exec?(user)
    false #self.users.include?(user)
  end

  def most_recent_page
    descriptions.order("created_at DESC").first
  end

  def author
    most_recent_page.user.name if most_recent_page
  end

  def contributors
    descriptions.includes(:user).map {|d| d.user.name}.uniq - [author]
  end


  def self.recently_updated(num)
    Description.order("updated_at desc").includes(:group).group("descriptions.group_id").map(&:group).take(num)
  end

  def self.find_by_description_id(id)
    Group.find(Description.find(id).group_id)
  end

  def self.search(name)
    like = Rails.env.production? ? "ILIKE" : "LIKE"
    Group.where("name #{like} ?", "%#{name}%")
  end

  def self.progress
    num_groups = Group.count
    num_pages = Group.includes(:descriptions).select {|g| g.descriptions.length > 0}.length
    frac = num_pages / num_groups.to_f
    percent = (frac*100).round
  end

end
