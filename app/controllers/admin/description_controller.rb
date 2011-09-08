class Admin::DescriptionController < AdminController
  def index
    @descriptions = Description.all
  end
end