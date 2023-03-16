class HousesController < ApplicationController
  before_action :authenticate_user!
  def index
    @house = House.new
  end

  def create
    @house = current_user.build_house(house_params)

    if @house.save
      render turbo_stream: turbo_stream.replace('house_form', partial: 'houses/house_name', locals: { house_name: @house.name })
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
