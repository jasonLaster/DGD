class Admin::GroupExecController < AdminController
  def index
    @group_execs = GroupExec.all
  end
end