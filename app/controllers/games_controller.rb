class GamesController < ApplicationController
  before_action :set_house, only: [:create]

  def create
    @game = @house.games.build
    if @game.save
      p '*'*100
      p @game
    else
      p '*'*100
      p @game.errors.messages
      p '*'*100
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
