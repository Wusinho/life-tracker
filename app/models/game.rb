class Game < ApplicationRecord
  belongs_to :house
  has_many :players, dependent: :destroy
  accepts_nested_attributes_for :players, allow_destroy: true, reject_if: :all_blank

  # after_create_commit{ broadcast_prepend_to 'games'}
  # after_update_commit{ broadcast_prepend_to 'games'}
  # after_destroy_commit{ broadcast_prepend_to 'games'}

  after_create :add_game

  def add_game
    self.players.each do |player|
      p '*'*100
      p player.user_id
      p '*'*100
      ActionCable.server.broadcast "game_channel_#{player.user_id}", {
        user_id: player.user_id,
        element: ApplicationController.render(partial: 'games/game', locals: { game: self })
      }
    end

  end

end
