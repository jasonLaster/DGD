# require 'spec_helper'
#
# describe "Descriptions" do
#   render_views
#
#   describe "GET /descriptions" do
#
#     it "/group/1/descriptions shows an empty history if the group has no descriptions" do
#       group = FactoryGirl.create(:group)
#       get group_description_index_path(group)
#       response.status.should be(200)
#     end
#
#     it "/group/1/descriptions shows the history of a group's descriptions" do
#       group = FactoryGirl.create(:group)
#       5.times {FactoryGirl.create(:description, :description => "lorem")}
#
#       get group_description_index_path(group)
#       response.status.should be(200)
#     end
#
#   end
# end
