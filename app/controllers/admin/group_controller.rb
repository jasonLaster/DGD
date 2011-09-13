class Admin::GroupController < AdminController
  def index
    @groups = Group.includes(:category).order("categories.category ASC, groups.name ASC")
  end
  
  def update
    
    form_groups = params['groups']
    db_groups = Group.find(form_groups.keys)

    form_groups.each do |group_id, form_group|
      db_group = db_groups.find {|c| group_id.to_i == c.id}
      form_group_locked =  form_group['locked'] == "1"

      # LOCKED
      if form_group_locked != db_group.locked
        db_group.locked = form_group_locked
        db_group.save
      end
      
      # GROUP NAME
      if form_group['name']!= db_group.name
        db_group.name = form_group['name']
        db_group.save
      end
      
      # CATEGORY
      if form_group['category'].present? && form_group['category'] != db_group.category.try(:id).try(:to_s)
        db_group.category_id = form_group['category'].to_i
        db_group.save
      end
      
      
    end
    
    
    
    redirect_to admin_group_index_path
  end

end