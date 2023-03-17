class HousesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_house, only: [:edit, :update]
  def index
    @new_house = House.new
    @house = current_user.house
    if @house
      @game = @house.games.find_by(ended: false)
    end
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
        render turbo_stream: turbo_stream.replace('error_message', partial: 'shared/error_message',
                                                  locals: { message: @house.errors.full_messages.to_sentence })
      end
  end

  def update
    current_user.house.update(house_params)
  end

  private

  def set_house
    @house = current_user.house
  end

  def house_params
    params.require(:house).permit(:name)
  end
end
