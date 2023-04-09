class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game, dependent: :destroy
  after_create :set_turn

  after_update_commit { broadcast_update_to "game_#{self.game.id}" }

  def died?
    self.lives.zero?
  end

  def set_turn
    return unless position == 1

    self.update(my_turn: true)
  end


  def damage_analysis(current_user, game, method)
    return unless current_user.player

    self.update(lives: self.lives - 1)
    current_user.player.increment!(:damage_done)
    user_stats(method, current_user)

    return unless self.died?
    update_player_active_status
    UserKill.create(user_id: current_user.id, deceased_id: self.user_id, game_id: self.game_id)
    self.user.update_win_rate
    if current_user.player.died? && self.my_turn == false || self.died? && self.my_turn == true
      players_turn = game.next_player(self)
      players_turn.update(my_turn: true)
    end

    return unless current_user_won?(game, current_user)

    current_user.player.update(winner: true, active: false )
    current_user.increment!(:wins)
    current_user.update_win_rate
    game.update(ended: true)
    rescue
      current_user.find_last_player_updated.update(winner: false)
      game.update(ended: true)
  end

  def update_player_active_status
    self.update(active: false)
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
