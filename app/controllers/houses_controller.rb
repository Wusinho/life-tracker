class HousesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_house, only: [:edit]
  def index
    @house = current_user.house || House.new
    @game = Game.new
  end

  def edit; end

  def create
    @house = current_user.build_house(house_params)

    if @house.save
      streams = []
      # streams << turbo_stream.remove('house_form')
      streams << turbo_stream.replace('house_form', partial: 'houses/edit_drop_down', locals: { house: @house })
      streams << turbo_stream.replace('house_name', partial: 'houses/house_name', locals: { house_name: @house.name })
      render turbo_stream: streams
    else
      render turbo_stream: turbo_stream.replace('error_message', partial: 'shared/error_message',
                                                locals: { message: @house.errors.full_messages.to_sentence })
    end
  end

  def update
    streams = []
    if current_user.house.update(house_params)
      streams << turbo_stream.replace('house_form', partial: 'houses/edit_drop_down', locals: { house: @house })
      streams << turbo_stream.replace('house_name', partial: 'houses/house_name', locals: { house_name: @house.name })
    else
      streams << turbo_stream.replace('error_message', partial: 'shared/error_message',
                                      locals: { message: @house.errors.full_messages.to_sentence })
    end
    render turbo_stream: streams
  end

  private

  def set_house
    @house = current_user.house
  end

  def house_params
    params.require(:house).permit(:name)
  end
end
