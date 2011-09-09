class Description < ActiveRecord::Base

  belongs_to :group
  belongs_to :user

  def self.default_description
    File.open("public/empty_group_page.txt").read
  end
  
  def markdown
    return if self.description.nil?
    Redcarpet.new(self.description).to_html.html_safe
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
