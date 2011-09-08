class Admin::GroupController < AdminController
  def index
    @groups = Group.all[0..25]
  end
end