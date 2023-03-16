class HousesController < ApplicationController
  before_action :authenticate_user!
  def index
    @house = House.new
    @game = Game.new
  end

  def create
    @house = current_user.build_house(house_params)

    if @house.save
      streams = []
      streams << turbo_stream.remove('house_form')
      streams << turbo_stream.replace('house_name', partial: 'houses/house_name', locals: { house_name: @house.name })
      render turbo_stream: streams
    else
      render turbo_stream: turbo_stream.replace('error_message', partial: 'shared/error_message',
                                                locals: { message: @house.errors.full_messages.to_sentence })
    end

  end


  private

  def house_params
    params.require(:house).permit(:name)
  end
end
