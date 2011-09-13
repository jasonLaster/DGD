class FlagController < ApplicationController
  layout 'application'
  
  # could receive page parameter, group parameter, or no parameter
  # shows group, page, number of flags, potentially user names
  def index
    @flags = Hash.new(0)
    Flag.all.map do |flag|
      @flags[flag.description_id] += 1
    end
  end
end