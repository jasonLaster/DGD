class Admin::FlagController < AdminController
  def index
    @flags = Flag.page_table.second
  end
end