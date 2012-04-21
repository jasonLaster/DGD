require 'spec_helper'


describe UserController do
  render_views
  
  describe "POST petition" do 
    it "will create a group exec if one doesn't already exist" do
      group = FactoryGirl.create(:group)
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
            
      post :petition, {:group_id => group.id, :id => user.id}
      GroupExec.where(:user_id => user.id, :group_id => group.id).first.should be_a(GroupExec)
      
    end

  end
  

end