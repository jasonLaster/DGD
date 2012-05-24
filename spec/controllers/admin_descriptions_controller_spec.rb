require 'spec_helper'


describe Admin::DescriptionController do
  render_views

  describe "GET description" do

    before(:all) do
      category = FactoryGirl.create(:category)
      group = FactoryGirl.create(:group, :category => category)
      user = FactoryGirl.create(:user)
      description = FactoryGirl.create(:description, :group => group, :user => user, :description => "lorem ipsum")
    end

    after(:all) do
      [Group, User, Category, Description].each do |model|
        model.all.each &:destroy
      end
    end

    it "admin should be able to see page" do
      user = User.first
      user.update_attribute(:admin, true)
      session[:user_id] = user.id

      group = Group.first
      get :index

      response.code.to_i.should == 200
      response.body.should match group.name
    end

    it "admin should be able to filter by primary category" do
      user = User.first
      user.update_attribute(:admin, true)
      session[:user_id] = user.id

      category = Category.first
      group = Group.first
      get :index, :primary_category => category.primary_category

      response.code.to_i.should == 200
      response.body.should match group.name

    end

  end
end

