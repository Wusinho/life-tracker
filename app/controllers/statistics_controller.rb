class StatisticsController < ApplicationController
  def index
    @users = User.order_wins.limit(5)
  end
end
