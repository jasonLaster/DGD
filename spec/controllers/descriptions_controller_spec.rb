require 'spec_helper'

describe DescriptionController do
  render_views
  
  describe "GET group/descriptions" do

    it "shows an empty history if the group has no descriptions" do
      group = FactoryGirl.create(:group)
      get :index, {:group_id => 1}
      
      response.status.should be(200)
    end

    it "shows the history of a group's descriptions" do
      group = FactoryGirl.create(:group)
      2.times {FactoryGirl.create(:description, :description => "lorem")}
      FactoryGirl.create(:description, :description => "<h2>lorem</h2>")
      
      get :index, {:group_id => group.id }
      response.status.should be(200)
      response.body.should match group.name
    end
        
  end
end
