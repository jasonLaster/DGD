class Description < ActiveRecord::Base

  has_one :group

  def self.default_description
    File.open("public/empty_group_page.txt").read
  end
  
  def markdown
    Redcarpet.new(self.description).to_html.html_safe
  end
end
