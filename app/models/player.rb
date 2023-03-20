class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game

  after_update_commit { broadcast_replace_to "players" }

  def died?
    self.lives.zero?
  end

end
