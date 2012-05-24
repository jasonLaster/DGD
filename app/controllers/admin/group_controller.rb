class Admin::GroupController < AdminController

  def foo
    params[:foo].dfg
    ert
  end

  def index
    category = params[:category] || "Athletics"
    @category = category.gsub("+", " ").strip

    @groups =
      if category == "all"
        Group.all
      elsif category == "none"
        Group.includes(:category).
          where("category is null").
          order("categories.category ASC, groups.name ASC")
      elsif category.present?
        Group.includes(:category).
          order("categories.category ASC, groups.name ASC").
          where("category LIKE ?", "%#{@category}%")
      else
        Group.includes(:category).
          order("categories.category ASC, groups.name ASC")
      end


    5.times {@groups << Group.new}

    @category_hash = Category.all.map {|c| {:label => c.category, :value => c.category, :id => c.id}}
  end

  def update

    form_groups = params['groups']
    form_groups, new_groups = form_groups.partition {|g| is_i?(g.first)}.map {|g| Hash[g]}
    db_groups = Group.find(form_groups.keys)

    form_groups.each do |group_id, form_group|
      db_group = db_groups.find {|c| group_id.to_i == c.id}
      form_group_locked =  form_group['locked'] == "1"

      # LOCKED
      if form_group_locked != db_group.locked
        db_group.locked = form_group_locked
        db_group.save
      end

      # DELETE
      if form_group['delete'] == "1"
        db_group.destroy
        next
      end


      # GROUP NAME
      if form_group['name']!= db_group.name
        db_group.name = form_group['name']
        db_group.save
      end

      # CATEGORY
      if form_group['category_id'].present? && form_group['category_id'] != db_group.category.try(:id).try(:to_s)
        db_group.category_id = form_group['category_id'].to_i
        db_group.save
      end
    end

    # new groups
    new_groups = new_groups.values.select {|g| g['name'].present?}
    new_groups.each {|group| group.delete("delete")}
    new_groups.each {|group| Group.create(group)}



    redirect_to admin_group_index_path
  end

  protected


  def is_i?(string)
     !!(string =~ /^[-+]?[0-9]+$/)
  end


end