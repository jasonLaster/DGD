class Description < ActiveRecord::Base

  belongs_to :group
  belongs_to :user
  has_many :flags
  has_many :users, :through => :flags, :as => :flaggers

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
  
  def self.most_recent

    sql =
      "
      select *
      from descriptions d1
      where d1.created_at = 
      	(
      		select MAX(d2.created_at)
      		from descriptions d2
      		where d1.group_id = d2.group_id
      	)
      "
    
    Description.find_by_sql(sql)
  end
  
end
