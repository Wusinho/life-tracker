class HousesController < ApplicationController
  before_action :authenticate_user!
  def index
    @house = House.new
  end

  def create
  end
end
