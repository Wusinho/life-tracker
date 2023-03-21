class StatisticsController < ApplicationController
  def index
    @users = User.all
  end
end
