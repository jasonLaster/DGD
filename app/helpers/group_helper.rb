module GroupHelper

  def flag_text 
    if @user_flag.present? then "Unflag"
    elsif @flag_count > 0 then "Flag (#{@flag_count})"
    else "Flag"
    end
  end

end
