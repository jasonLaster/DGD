require 'spec_helper'


describe GroupController do
  render_views
  
  describe "GET group/id" do 
    
    #  USER-LESS
    it "renders an empty page if the group doesnt have a description" do
      group = FactoryGirl.create(:group)
      get :show, {:id => 1}
      puts page.body
    end

    it "renders a page if one exists"
  
    it "renders the most recent page if the group has multiple descriptions"
  
  
    # LOGGED IN USER
    
    # LOGGED IN ADMIN
  end
  
  describe "GET group/1 simple page"
  

end