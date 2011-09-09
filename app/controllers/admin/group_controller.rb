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

      if form_group_locked != db_group.locked
        db_group.locked = form_group_locked
        db_group.save
      end
      
      if form_group['name']!= db_group.name
        db_group.name = form_group['name']
        db_group.save
      end
      
    end
    
    
    
    redirect_to admin_group_index_path
  end

end