class Game < ApplicationRecord
  belongs_to :house
  has_many :players, dependent: :destroy
  accepts_nested_attributes_for :players, allow_destroy: true, reject_if: :all_blank

  after_create :add_game
  # after_update_commit { broadcast_update_to game, :players }

  def add_game
    self.players.each do |player|
      player.user.update(total_games: player.user.total_games + 1)
      ActionCable.server.broadcast "game_channel_#{player.user_id}", {
        user_id: player.user_id,
        element: ApplicationController.render(partial: 'games/game', locals: { game: self })
      }
    end

  end

end
