class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game

  # after_create_commit{ broadcast_prepend_to 'players', partial: 'games/players', locals: { player: self }, target: 'players' }

end
