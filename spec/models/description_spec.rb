require 'spec_helper'

describe Description do


  before(:all) do
  end

  after(:all) do
    [Group, User, Category, Description].each do |model|
      model.all.each &:destroy
    end
  end


  it "#most_recent should return the most recent description for each group" do

    g1 = FactoryGirl.create(:group)
    g2 = FactoryGirl.create(:group)
    user = FactoryGirl.create(:user)
    d1 = FactoryGirl.create(:description, :created_at => "1-1-12", :group => g1, :user => user)
    d2 = FactoryGirl.create(:description, :created_at => "1-2-12", :group => g1, :user => user)
    d3 = FactoryGirl.create(:description, :created_at => "1-3-12", :group => g2, :user => user)

    descriptions = Description.most_recent.chronological
    descriptions.map(&:group_id).uniq.length.should eq(2)
    descriptions.should include(d2, d3)
    descriptions.find_index(d2).should > descriptions.find_index(d3)
  end

end
