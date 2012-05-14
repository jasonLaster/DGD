class Description < ActiveRecord::Base

  belongs_to :group
  belongs_to :user
  has_many :flags
  has_many :users, :through => :flags, :as => :flaggers
  
  validates :group_id, :presence => true
  validates :user_id, :presence => true

  scope :chronological, order("created_at desc")

  def self.default_description
    File.open("public/empty_group_page.txt").read
  end
  
  def markdown
    return if self.description.nil?
    Redcarpet::Markdown.new(Redcarpet::Render::HTML,:autolink => true, :space_after_headers => true).render(self.description).html_safe
  end
  
  def self.markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML,:autolink => true, :space_after_headers => true).render(text).html_safe
  end
  
  def self.total_count
    Description.group(:group_id).count.keys.length
  end

  # show the most recent page for each group.
  def self.most_recent
    where("descriptions.created_at = (select MAX(d2.created_at) from descriptions d2 where descriptions.group_id = d2.group_id)")
  end
  
  def self.leaderboard
    Description.most_recent.includes(:user).group_by(&:user_id).values.sort_by(&:length).reverse
  end
  
end
