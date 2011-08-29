class SplashController < ActionController::Base
  def index
    @group_hash = Group.all.map {|g| {:label => g.name, :value => g.name, :id => g.id}}
  end
end