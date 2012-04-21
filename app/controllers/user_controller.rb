class UserController < ApplicationController
  def petition
    @group = Group.find_by_id(params[:group_id])
    GroupExec.find_or_create_by_user_id_and_group_id(:user_id => @current_user.id, :group_id => @group.id)
    redirect_to group_path(@group)
  end
end