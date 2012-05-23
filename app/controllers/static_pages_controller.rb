class StaticPagesController < ApplicationController
  caches_page :about

  def about
    @leaderboard = Description.leaderboard
    @number_of_groups_with_pages = Description.total_count
  end

end
