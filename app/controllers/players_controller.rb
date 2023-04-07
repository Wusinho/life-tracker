class PlayersController < ApplicationController
  before_action :set_player, only: [:damage_to_enemies, :heal, :damage_to, :kaboom, :pass]

  def pass
    @player.update(my_turn: false)

    whose_turn = @game.game_size >= @player.position + 1 ?  @player.position + 1 : 1
    p '*'*100
    p whose_turn
    player = @game.players.find_by(position: whose_turn)
    p player
    p '*'*100

    player.update(my_turn: true)
  end
  def windows_close
    return unless user_signed_in?

    current_user.update(online: false)
    reset_session
  end

  def kaboom
    return if @game.ended

    @game.players.each do |player|
      next if player.died?

      player.damage_analysis(current_user, @game, __method__)
    end

  end

  def damage_to_enemies
    return if @game.ended

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
    @player = Player.find(params[:id])
    @game = @player.game
  end
end
