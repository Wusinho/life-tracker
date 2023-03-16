class HousesController < ApplicationController
  before_action :authenticate_user!
  def index
    @house = House.new
  end

  def create
    @house = current_user.build_house(house_params)

    if @house.save
      p @house
    else
      p @house.errors.full_messages
    end

  end


  private

  def house_params
    params.require(:house).permit(:name)
  end
end
