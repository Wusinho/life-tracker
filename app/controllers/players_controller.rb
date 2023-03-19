class PlayersController < ApplicationController
  before_action :set_player, only: [:damage_to_enemies]


  def damage_to_enemies
    render json: {
      player: @player,
      game: @game
    }
  end

  def heal
    render json: {
      player: @player,
      game: @game
    }
  end

  def damage_to
    render json: {
      player: @player,
      game: @game
    }
  end

  private

  def set_player
    @player = Player.find(params[:id])
    @game = @player.game
  end
end
