module DescriptionsHelper
  def history_title(description)
    if description.is_a?(Description)
      date = description.created_at.strftime("%b %d at %I:%M%p")
      name = description.user.try(:first_name)
      return "#{name} - #{date}"
    end
  end
end
