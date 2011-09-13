class User < ActiveRecord::Base
  
  # Models the flag relationship
  has_many :descriptions
  
  def first_name
    name.split(" ").first
  end
  
  def last_name
    name.split(" ").last
  end

  def self.create_with_omniauth(auth)  
    create! do |user|
      user.name = auth["extra"]["name"]
      user.email = auth['uid'].split.join(".").gsub('..', '.')
    end  
  end
  
end
