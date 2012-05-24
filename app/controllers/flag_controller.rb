class FlagController < ApplicationController
  layout 'application'

  # could receive page parameter, group parameter, or no parameter
  # shows group, page, number of flags, potentially user names
  def index
    @group = Group.find(params[:group_id])
    @flags = Flag.page_table.second
  end
end