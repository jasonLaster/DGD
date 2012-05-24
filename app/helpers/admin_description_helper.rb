module AdminDescriptionHelper
  def page_header
    "#{@sub_category.primary_category} / #{@sub_category.sub_category}"
  end

  def current_subcategory?(category)
    @sub_category.present? && (@sub_category == category)
  end
end