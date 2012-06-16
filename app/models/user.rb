class User < ActiveRecord::Base

  has_many :descriptions

  has_many :group_execs
  has_many :groups, :through => :group_execs

  has_many :flags
  has_many :descriptions, :through => :flags, :as => :flagged_descriptions


  def first_name
    name.present? ? name.split(" ").first : ""
  end

  def last_name
    name.split(" ").last
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.name = auth['info']['name']
      user.email = auth['uid'].split.join(".").gsub('..', '.')
    end
  end

end
