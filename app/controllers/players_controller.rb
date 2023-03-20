class PlayersController < ApplicationController
  before_action :set_player, only: [:damage_to_enemies, :heal, :damage_to, :kaboom]

  def kaboom
    @game.players.each do |player|
      next if player.died?

      player.update(lives: player.lives - 1)
    end

  end

  def damage_to_enemies
    @game.players.each do |player|
      next if player.user == current_user || player.died?

      player.update(lives: player.lives - 1)
    end
  end

  def heal
    @player.update(lives: @player.lives + 1)

  end

  def damage_to
    @player.update(lives: @player.lives - 1)

  end

  private

  def set_player
    @player = Player.find(params[:id])
    @game = @player.game
  end
end
