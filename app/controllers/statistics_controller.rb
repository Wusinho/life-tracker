class StatisticsController < ApplicationController
  before_action :set_user, only: [:show]
  def index
    @users = User.order_wins.limit(5)
  end

  def show

  end

  private

  def set_user
    @user = User.find(params['id'])
  end

end
