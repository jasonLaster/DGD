module DescriptionsHelper
  def history_title(description)
    if description
      name = description.user.try(:first_name)
      date = description.created_at.strftime("%b %d at %I:%M%p")
      return "#{name} - #{date}"
    end
  end
end
