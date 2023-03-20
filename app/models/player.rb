class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game

  after_update_commit { broadcast_replace_to "game_#{self.game.id}" }

  def died?
    self.lives.zero?
  end

end
