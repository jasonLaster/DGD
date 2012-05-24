require 'spec_helper'


describe GroupController do

  #  NO LOGGED IN USER
  describe "(not-logged in) GET group/id" do

    before(:all) do
      group = FactoryGirl.create(:group)
      user = FactoryGirl.create(:user)
    end

    after(:all) do
      [Group, User, Category, Description].each do |model|
        model.all.each &:destroy
      end
    end


    it "Group has no description" do
      group = Group.first
      get :show, {:id => group.id}
      assigns(:description).should be_a_new(Description)
    end

    it "Group has a description without content" do
      group = Group.first
      group.descriptions.build(:user_id => User.first.id).save

      get :show, {:id => group.id}
      response.code.to_i.should == 200
    end

    it "Group has a description without a user" do
      group = Group.first
      group.descriptions.build().save

      get :show, {:id => group.id}
      response.code.to_i.should == 200
    end


    it "renders a page if one exists" do
      group = Group.first
      group.descriptions.build(:description => "test page", :user_id => User.first).save

      get :show, {:id => group.id}
      description = assigns(:description)
      description.should_not be_a_new(Description)
      description.description.should eq("test page")

    end

    it "renders the most recent page if the group has multiple descriptions"

  end

  # LOGGED IN ADMIN
  describe "(ADMIN) GET group/id"

  # LOGGED IN USER
  describe "(USER) GET group/id" do

    before(:all) do
      group = FactoryGirl.create(:group)
      user = FactoryGirl.create(:user)
    end

    after(:all) do
      [Group, User, Category, Description].each do |model|
        model.all.each &:destroy
      end
    end

    it "USER: Group has no description" do
      group = Group.first
      get :show, {:id => group.id}
    end
  end


end