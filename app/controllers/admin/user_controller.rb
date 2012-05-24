class Admin::UserController < AdminController
  def index
    @users =
      if params[:admin]
        User.where(:admin => true)
      elsif params[:blocked]
        User.where(:blocked => true)
      else
        User.all
      end

  end

  def update
    form_users = params['users']
    db_users = User.find(form_users.keys)

    form_users.each do |user_id, form_user|
      db_user = db_users.find {|u| user_id.to_i == u.id}

      form_user_admin = form_user['admin'] == "1"
      form_user_blocked =  form_user['blocked'] == "1"

      if form_user_admin != db_user.admin
        db_user.admin = form_user_admin
        db_user.save
      end

      if form_user_blocked != db_user.blocked
        db_user.blocked = form_user_blocked
        db_user.save
      end

      if form_user['name']!= db_user.name
        db_user.name = form_user['name']
        db_user.save
      end

      if form_user['email']!= db_user.email
        db_user.email = form_user['email']
        db_user.save
      end

    end

    redirect_to admin_user_index_path
  end

end