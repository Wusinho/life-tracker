class StatisticsController < ApplicationController
  def index
    @users = User.order_wins
  end
end
