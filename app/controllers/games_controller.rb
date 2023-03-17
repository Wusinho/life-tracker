class GamesController < ApplicationController
  before_action :set_house, only: [:create]

  def show

  end

  def create
    @game = @house.games.build


      if @game.save
        respond_to do |format|
          format.html { redirect_to @game }
        end

      else
        p '*'*100
        p @game.errors.messages

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
