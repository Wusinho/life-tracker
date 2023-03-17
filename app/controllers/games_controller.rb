class GamesController < ApplicationController
  before_action :set_house, only: [:create]

  def create
    @game = @house.games.build

    respond_to do |format|

      if @game.save
        format.turbo_stream
        format.html
      else
        p '*'*100
        p @game.errors.messages

      end
    end

  end

  def update
    @game = Game.find(params['id'])
  end

  private

  def set_house
    @house = House.find(params['id'])
  end

end
