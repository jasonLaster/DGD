require 'spec_helper'


describe 'Anonymous User' do

  before(:all) do
    FactoryGirl.create(:category)
    group = FactoryGirl.create(:group, :name => "Test Group", :category => Category.first)
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:description, :description => "Lorem Ipsum", :user => user, :group => group)
  end

  after(:all) do
    [Group, User, Category, Description].each do |model|
      model.all.each &:destroy
    end
  end

  it 'Shows a Directory' do
    group = Group.find_by_name("Test Group")
    visit group_index_path
    page.should have_content('Directory')
    page.should have_content(group.name)
  end

  it 'Shows a Group page' do
    group = Group.find_by_name("Test Group")
    visit group_path(group)
    page.should have_content(group.name)
    page.should have_content(group.most_recent_page.description.html_safe)
  end

end