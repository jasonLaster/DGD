class FlagController < ActionController::Base
  layout 'application'
  
  def index
    @flags = Hash.new(0)
    Flag.all.map do |flag|
      @flags[flag.description_id] += 1
    end
  end
end