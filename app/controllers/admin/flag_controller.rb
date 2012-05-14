class Admin::FlagController < AdminController
  def index
    @flags = Flag.by_description
  end
end