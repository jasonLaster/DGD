require 'spec_helper'


describe Admin::GroupController do
  describe "GET group" do
    
    before(:all) do
      group = FactoryGirl.create(:group)
      user = FactoryGirl.create(:user)
    end
    
    after(:all) do
      [Group, User, Category, Description].each do |model|
        model.all.each &:destroy
      end
    end
    
    it "anonymous user should not be able to see index" do
      get :index
      response.code.to_i.should == 302
    end
    
    it "regular user should not be able to see index" do
      user = User.first
      session[:user_id] = user.id
      get :index
      response.code.to_i.should == 302
    end
    
    it "admin should be able to vew index" do 
      user = User.first
      user.update_attribute(:admin, true)
      session[:user_id] = user.id
      get :index
      response.code.to_i.should == 200
    end
  end

  describe "POST update" do
    
    before(:all) do
      group = FactoryGirl.create(:group)
      user = FactoryGirl.create(:user)
    end
    
    after(:all) do
      [Group, User, Category, Description].each do |model|
        model.all.each &:destroy
      end
    end
    
    
    it "should be able to change a group's info" do 
      # login
      user = User.first
      user.update_attribute(:admin, true)
      session[:user_id] = user.id

      # update group
      group = Group.first
      post :update, "groups"=>{group.id.to_s =>{"delete"=>"", "locked"=>"1", "name"=>"TEST", "category_id"=>"3"}}
      response.code.to_i.should == 302
      
      
      # change group name
      group = Group.first
      group.name.should == "TEST"
      group.locked.should == true
      group.category_id.should == 3
      
    end
    
    it "should be able to delete group"
    
    # it "should be able to create group" do
    #   # login
    #   user = User.first
    #   user.update_attribute(:admin, true)
    #   session[:user_id] = user.id
    # 
    #   # update group
    #   group = Group.first
    #   post :update, "groups"=> {"new1"=>{"delete"=>"", "locked"=>"", "name"=>"TEST", "category_id"=>"1"}}
    #   response.code.to_i.should == 302      
    #   
    #   group = Group.find_by_name("TEST")
    #   group.should be_an_instance_of(Group)
    #   
    # end
    
  end


  
end

