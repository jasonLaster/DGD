class StaticPagesController < ApplicationController

  def about
    @leaderboard = Description.leaderboard_fast
    @number_of_groups_with_pages = Description.total_count
  end

end
