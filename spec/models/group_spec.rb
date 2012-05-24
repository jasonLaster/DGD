require 'spec_helper'

describe Group do


  it "#recently_updated" do
    g1 = FactoryGirl.create(:group)
    g2 = FactoryGirl.create(:group)
    u = FactoryGirl.create(:user)
    d1 = FactoryGirl.create(:description, :updated_at => "1-1-12", :group => g1, :user => u)
    d2 = FactoryGirl.create(:description, :updated_at => "1-2-12", :group => g1, :user => u)
    d3 = FactoryGirl.create(:description, :updated_at => "1-3-12", :group => g2, :user => u)

    groups = Group.recently_updated(2)
    groups.length.should == 2
    groups.first.should == g2
    groups.second.should == g1

  end

  it "#search" do
    g1 = FactoryGirl.create(:group, :name => "My Group")
    g = Group.search("My Group")
    g.first.should == g1
  end

end
