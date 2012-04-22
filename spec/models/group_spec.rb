require 'spec_helper'

describe Group do
  
  
  it "#recently_updated" do
    g1 = FactoryGirl.create(:group)
    g2 = FactoryGirl.create(:group)
    d1 = FactoryGirl.create(:description, :updated_at => "1-1-12", :group => g1)
    d2 = FactoryGirl.create(:description, :updated_at => "1-2-12", :group => g1)
    d3 = FactoryGirl.create(:description, :updated_at => "1-3-12", :group => g2)
    
    groups = Group.recently_updated(2)
    groups.length.should == 2
    groups.first.should == g2
    groups.second.should == g1
  
  end
  
end
