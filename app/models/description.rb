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
end
