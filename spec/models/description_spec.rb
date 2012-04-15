require 'spec_helper'

describe Description do
  
  
  it "#most_recent should return the most recent description for each group" do
    g1 = FactoryGirl.create(:group)
    g2 = FactoryGirl.create(:group)
    d1 = FactoryGirl.create(:description, :created_at => "1-1-12", :group => g1)
    d2 = FactoryGirl.create(:description, :created_at => "1-2-12", :group => g1)
    d3 = FactoryGirl.create(:description, :created_at => "1-3-12", :group => g2)
  
    descriptions = Description.most_recent.chronological

    descriptions.map(&:group_id).uniq.length.should eq(2)    
    descriptions.should include(d2, d3)
    descriptions.find_index(d2).should > descriptions.find_index(d3)
  end
  
end
