class Admin::CategoryController < AdminController
  def index
    @categories = Category.all.sort_by(&:category)
    5.times {@categories << Category.new}
  end

  def primary_categories
    @categories = Category.primary_categories.map {|c| [c, Category.sub_categories(c).map(&:sub_category)]}.sort_by {|c,l| -l.length}
  end

  def update

    form_categories = params['categories']
    form_categories, new_categories = form_categories.partition {|c| is_i?(c.first)}.map {|c| Hash[c]}
    db_categories = Category.find(form_categories.keys)

    # update existing categories
    form_categories.each do |category_id, form_category|
      db_category = db_categories.find {|c| category_id.to_i == c.id}

      if form_category['delete'] == "1"
        Group.find_all_by_category_id(db_category).map {|g| g.update_attribute(:category_id,  nil)}
        db_category.destroy
        next
      end

      if form_category['category'] != db_category.category
        db_category.category = form_category['category']
        db_category.save
      end

    end

    # new categories
    new_categories = new_categories.values.map(&:values).map(&:first).select(&:present?)
    new_categories.each {|category| Category.create(:category =>  category)}

    redirect_to admin_category_index_path
  end

  protected


  def is_i?(string)
     !!(string =~ /^[-+]?[0-9]+$/)
  end

end