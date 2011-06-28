class User < ActiveRecord::Base

  def self.create_with_omniauth(auth)  
    create! do |user|
      user.name = auth["extra"]["name"]
    end  
  end
  
end
