require 'spec_helper'

describe DescriptionController do
  render_views

  describe "GET group/id/descriptions" do

    before(:all) do
      group = FactoryGirl.create(:group)
      user = FactoryGirl.create(:user)
    end

    after(:all) do
      [Group, User, Category, Description].each do |model|
        model.all.each &:destroy
      end
    end


    it "shows an empty history if the group has no descriptions" do
      get :index, {:group_id => Group.first.id}
      response.status.to_i.should == 200
    end

    it "shows the history of a group's descriptions" do
      group = FactoryGirl.create(:group)
      user = User.first

      2.times {FactoryGirl.create(:description, :group => group, :description => "lorem", :user => user)} # normal description
      FactoryGirl.create(:description, :group => group, :user => user) # empty description
      FactoryGirl.create(:description, :group => group, :description => "<h2>lorem</h2>", :user => user) # description with html

      get :index, {:group_id => group.id }
      response.status.should be(200)
      response.body.should match group.name
      assigns(:descriptions).length.should == 4

    end


  end

  describe "POST group/id/checklist" do

    before(:all) do
      FactoryGirl.create(:group)
      FactoryGirl.create(:user)
    end

    after(:all) do
      [Group, User, Category, Description].each do |model|
        model.all.each &:destroy
      end
    end


    it "create a new description if none exists" do
      group = Group.first
      session[:user_id] = User.first
      put :checklist, {"group_id" => group.id, "description"=>{"exec_list"=>"0", "description_text"=>"1", "contact_information"=>"1", "events"=>"0"}}

      group.descriptions.length.should == 1
      description = group.descriptions.first
      description.description_text.should == true
      description.user.should == assigns(:current_user)

    end

    it "update an existing description if it exists" do
      group = Group.first
      user = User.first
      group.descriptions.build(:exec_list => 1, :description => "test page", :user_id => user.id).save

      session[:user_id] = user.id
      put :checklist, {"group_id" => group.id, "description"=>{"exec_list"=>"0", "description_text"=>"1", "contact_information"=>"1", "events"=>"0"}}


      # response.should render_template("description/checklist_form")
      response.should_not redirect_to(group_index_path)
      group = assigns(:group)
      group.descriptions.length.should == 1
      description = group.most_recent_page
      description.description_text.should == true
      description.exec_list.should == false
    end

    it "throw an exception if nobody is logged in" do
      group = Group.first
      put :checklist, {"group_id" => group.id, "description"=>{"exec_list"=>"0", "description_text"=>"1", "contact_information"=>"1", "events"=>"0"}}
      group.descriptions.length.should == 0

      response.should redirect_to(group_index_path)
    end


  end

  describe "POST group/id/description" do

    before(:all) do
      FactoryGirl.create(:group)
      FactoryGirl.create(:user)
    end

    after(:all) do
      [Group, User, Category, Description].each do |model|
        model.all.each &:destroy
      end
    end


    it "create a new description if none exists" do
      group = Group.first
      user = User.first
      session[:user_id] = user.id
      post :create, {"group_id" => group.id, "description" => {"description" => "test page"}}
      group = assigns(:group)
      group.descriptions.length.should == 1
      group.descriptions.first.description.should == "test page"
    end

    it "creates a new description and keeps existing checklist" do
      group = Group.first
      user = User.first
      group.descriptions.build(:description => "test page 1", :exec_list => 1, :user_id => user.id).save
      session[:user_id] = user.id
      post :create, {"group_id" => group.id, "description" => {"description" => "test page 2"}}


      group = assigns(:group)
      group.descriptions.length.should == 2

      most_recent_page = group.most_recent_page
      most_recent_page.exec_list.should == true
      most_recent_page.description.should == "test page 2"

    end

    it "description's author should be the logged in user" do
      group = Group.first
      user1 = User.first
      user2 = FactoryGirl.create(:user)

      group.descriptions.build(:description => "test page 1", :exec_list => 1, :user_id => user1.id).save
      session[:user_id] = user2.id
      post :create, {"group_id" => group.id, "description" => {"description" => "test page 2"}}


      group = assigns(:group)
      group.descriptions.length.should == 2

      most_recent_page = group.most_recent_page
      most_recent_page.user.should == user2

    end

  end




end
