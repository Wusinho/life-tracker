module GamesHelper

  def damage_to_enemies(player, current_user)
    return unless player.user_id == current_user.id

      render 'players/damage_to_enemies', id: player.id
  end

end
