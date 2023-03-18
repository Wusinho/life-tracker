class HousesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_house, only: [:edit, :update]
  def index
    @new_house = House.new
    @house = current_user.house
  end

  def show
    @house = current_user.house
  end

  def edit; end

  def create
    @house = current_user.build_house(house_params)

      if @house.save
        respond_to do |format|
          format.turbo_stream
          format.html
        end
      else
        render turbo_stream: error_message(@house)
      end
  end

  def update
    if @house.update(house_params)
      redirect_to houses_path
    else
      render turbo_stream: error_message(@house)
    end
  end

  private




  def set_house
    @house = current_user.house
  end

  def house_params
    params.require(:house).permit(:name)
  end
end
