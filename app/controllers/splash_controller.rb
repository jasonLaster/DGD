class SplashController < ApplicationController
  def index
    @progress = Group.progress
  end
end