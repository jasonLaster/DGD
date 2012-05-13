class Admin::FlagController < AdminController
  def index
    if Flag.page_table.present?
      @flags = Flag.page_table.second
    end
  end
end