class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game

  # after_create_commit{ broadcast_prepend_to 'players', partial: 'games/players', locals: { player: self }, target: 'players' }
  after_update_commit { broadcast_update_to game, :players }
end
