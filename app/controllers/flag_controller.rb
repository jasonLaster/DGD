class FlagController < ActionController::Base  
  def index
    @flags = Flag.all
  end
end