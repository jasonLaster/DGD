module GroupHelper

  def flag_text
    if @user_flag.present? then "Unflag Content"
    elsif @flag_count > 0 then "Flag as Inappropriate (#{@flag_count})"
    else "Flag as Inappropriate"
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
