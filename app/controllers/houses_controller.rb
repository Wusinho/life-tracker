class HousesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_house, only: [:edit, :update ]
  before_action :set_creating_game, only: [:show ]

  def index
    @new_house = House.new
    @house = current_user.house
  end

  def show
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
        error_message(@house)
      end
  end

  def update
    if @house.update(house_params)
      redirect_to houses_path
    else
      error_message(@house)
    end
  end

  private

  def set_creating_game
    @game = Game.new
    @users = User.all
    @users.each { | user| @game.players.build(user_id: user.id) }
  end

  def set_house
    @house = current_user.house
  end

  def house_params
    params.require(:house).permit(:name)
  end
end
