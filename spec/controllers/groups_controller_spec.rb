require 'spec_helper'


describe GroupController do
  render_views

  #  NO LOGGED IN USER
  describe "GET group/id" do 
    
    setup do
      group = FactoryGirl.create(:group)
    end
    
    it "NO-USER: Group has no description" do
      group = Group.first
      get :show, {:id => group.id}
      assigns(:description).should be_a_new(Description)
      
    end

    it "renders a page if one exists" do
      group = Group.first
      group.descriptions.build(:description => "test page").save
      
      get :show, {:id => group.id}
      description = assigns(:description)
      description.should_not be_a_new(Description)
      description.description.should eq("test page")
      
    end
  
    it "renders the most recent page if the group has multiple descriptions"
  
    
    # LOGGED IN ADMIN
  end
  
  # LOGGED IN USER
  describe "GET group/1" do
    
    setup do
      group = FactoryGirl.create(:group)
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
    end
    
    it "USER: Group has no description" do 
      group = Group.first
      get :show, {:id => group.id}
    end
  end
  

end