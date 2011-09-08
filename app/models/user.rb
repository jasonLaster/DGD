class User < ActiveRecord::Base
  
  # Models the flag relationship
  has_many :descriptions
  
  def self.create_with_omniauth(auth)      
    create! do |user|
      user.name = auth["extra"]["name"]
      user.email = auth['uid'].split.join(".").gsub('..', '.')
    end  
  end
  
end
