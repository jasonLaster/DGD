class Admin::FlagController < AdminController
  def index
    @flags = Flag.by_group
  end
end