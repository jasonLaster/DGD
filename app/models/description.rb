class Description < ActiveRecord::Base

  has_one :group

  def self.default_description
    File.open("public/empty_group_page.txt").read
  end
end
