class PlayersController < ApplicationController
  before_action :set_player, only: [:damage_to_enemies, :heal, :damage_to, :kaboom]

  def kaboom
    @game.players.each do |player|

      player.decrement!(:lives)
    end

    render json: {
      player: current_user,
    }
  end

  def damage_to_enemies
    @game.players.each do |player|
      next if player.user == current_user

      player.decrement!(:lives)
    end
    render json: {
      player: @player,
    }
  end

  def heal
    @player.increment!(:lives)
    render json: {
      player: @player,
      lives: @player.lives,
      user: @player.user.nickname
    }
  end

  def damage_to
    @player.decrement!(:lives)
    render json: {
      player: @player,
      lives: @player.lives,
      user: @player.user.nickname
    }
  end

  private

  def set_player
    @player = Player.find(params[:id])
    @game = @player.game
  end
end
