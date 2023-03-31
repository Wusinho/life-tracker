class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game

  after_update_commit { broadcast_update_to "game_#{self.game.id}" }

  def died?
    self.lives.zero?
  end

  def damage_analysis(current_user, game, method)
    self.update(lives: self.lives - 1)
    user_stats(method, current_user)

    return unless self.died?
    update_player_active_status
    UserKill.create(user_id: current_user.id, deceased_id: self.user_id, game_id: self.game_id)

    return unless current_user_won?(game, current_user)

    current_user.player.update(winner: true, active: false )
    current_user.increment!(:wins)
    current_user.increment!(:total_games)
    game.update(ended: true)
  end

  def update_player_active_status
    self.update(active: false)
    self.user.increment!(:total_games)
  end

  def current_user_won?(game ,current_user)
    all_enemies = game.players.where.not(user_id: current_user.id)
    all_enemies.all? { |player| player.died? }
  end

  def nickname
    self.user.nickname
  end

  def user_stats(method, current_user)
    current_user.increment!(:aoe) unless method  == :damage_to
    current_user.increment!(:total_damage)
  end

end
