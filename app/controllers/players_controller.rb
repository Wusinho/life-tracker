class PlayersController < ApplicationController
  before_action :set_player, only: [:damage_to_enemies, :heal, :damage_to, :kaboom]

  def kaboom
    @game.players.each do |player|
      next if player.died?

      player.damage_analysis(current_user, @game, __method__)
    end

  end

  def damage_to_enemies
    @game.players.each do |player|
      next if player.user == current_user || player.died?

      player.damage_analysis(current_user, @game, __method__)
    end
  end

  def heal
    @player.update(lives: @player.lives + 1)
    current_user.increment!(:heal)
  end

  def damage_to
    @player.damage_analysis(current_user, @game, __method__)
  end

  private

  def set_player
    p '*'*100
    p params
    p '*'*100
    @player = Player.find(params[:id])
    @game = @player.game
  end
end
