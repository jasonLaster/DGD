class Admin::DescriptionController < AdminController
  def index
    if params[:primary_category].present?
      @type = :primary_category
      @primary_category = params[:primary_category]
      @descriptions = Category.primary_category_pages(@primary_category)
      @sub_categories = Category.sub_categories(@primary_category)
    elsif params[:sub_category].present?
      @type = :sub_category
      @sub_category = Category.find(params[:sub_category])
      @sub_categories = @sub_category.sub_categories
      @descriptions = @sub_category.pages
    else
      @type = :all
      @descriptions = Description.most_recent.chronological
    end
  end

  def update
    form_descriptions = params['descriptions']
    db_descriptions = Description.find(form_descriptions.keys)

    form_descriptions.each do |description_id, form_description|
      db_description = db_descriptions.find {|d| description_id.to_i == d.id}

      form_description_exec_list = form_description['exec_list'] == "1"
      form_description_description_text =  form_description['description_text'] == "1"
      form_description_contact_information =  form_description['contact_information'] == "1"
      form_description_events =  form_description['events'] == "1"

      if form_description_exec_list != db_description.exec_list
        db_description.exec_list = form_description_exec_list
        db_description.save
      end

      if form_description_description_text != db_description.description_text
        db_description.description_text = form_description_description_text
        db_description.save
      end

      if form_description_contact_information != db_description.contact_information
        db_description.contact_information = form_description_contact_information
        db_description.save
      end

      if form_description_events != db_description.events
        db_description.events = form_description_events
        db_description.save
      end

    end

    redirect_to admin_description_index_path
  end
end