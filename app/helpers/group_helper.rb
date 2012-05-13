module GroupHelper

  def flag_text 
    if @user_flag.present? then "Unflag"
    elsif @flag_count > 0 then "Flag (#{@flag_count})"
    else "Flag"
    end
  end
  
  def display_name(group)
    group.name.truncate(40)
  end
  
  def add_color(group)
    description_exists = group.descriptions.length > 0
    color = description_exists ? 'blue' : '#555'
    "color: #{color};"
  end

end
