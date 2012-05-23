require 'spec_helper'


describe UserController do
  render_views

  before(:all) do
    FactoryGirl.create(:group)
    FactoryGirl.create(:user)
  end

  after(:all) do
    [Group, User, Category, Description].each do |model|
      model.all.each &:destroy
    end
  end


  describe "POST petition" do
    it "will create a group exec if one doesn't already exist" do

      group = Group.first
      user = User.first

      session[:user_id] = user.id
      post :petition, {:group_id => group.id, :id => user.id}
      GroupExec.where(:user_id => user.id, :group_id => group.id).first.should be_a(GroupExec)

    end
  end
end