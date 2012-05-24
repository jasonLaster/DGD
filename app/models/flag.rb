class Flag < ActiveRecord::Base
  belongs_to :user
  belongs_to :description


  def self.flags
    Flag.includes(:description =>:group).includes(:user)
  end

  def self.by_description
    flags = Flag.flags.order("groups.name")

    flags.group_by(&:description).map do |description, flags|
      description = flags.first.description
      flaggers = flags.map {|f| f.user.name}.join("<br />").html_safe
      {
        :group => description.group,
        :group_name => description.group.name,
        :description => description,
        :flaggers => flaggers,
        :flag_count => flags.length
      }
    end
  end

  def self.group(group)
    Flag.by_group.where("groups.id is ?", group.id)
  end

end
