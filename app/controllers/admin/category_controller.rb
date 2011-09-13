class Admin::CategoryController < AdminController
  def index
    @categories = Category.all.sort_by(&:category)
  end

  def primary_categories
    @categories = Category.primary_categories.map {|c| [c, Category.sub_categories(c).map(&:sub_category)]}.sort_by {|c,l| -l.length}
  end

  def update
    
    form_categories = params['categories']
    db_categories = Category.find(form_categories.keys)

    form_categories.each do |category_id, form_category|
      db_category = db_categories.find {|c| category_id.to_i == c.id}
      
      if form_category['delete'] == "1"
        db_category.destroy 
        next
      end
      
      if form_category['category'] != db_category.category
        db_category.category = form_category['category']
        db_category.save
      end
      
    end
    
    redirect_to admin_category_index_path
  end
  
end