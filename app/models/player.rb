class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game

  after_update_commit { broadcast_replace_to "game_#{self.game.id}" }

  def died?
    self.lives.zero?
  end

  def damage_analysis(current_user, game)
    self.update(lives: self.lives - 1)

    return unless self.died?

    self.update(killer: current_user.id )

    current_user.player.update(winner: true ) if current_user_won?(game, current_user)
  end

  def current_user_won?(game ,current_user)
    alive_players = game.players.where.not(lives: 0)
    return unless alive_players.count == 1

    alive_players.first == current_user.player
  end

end
