class GameChannel < ApplicationCable::Channel
  def subscribed
    if current_user && params[:game_id]
      game = Game.find(params[:game_id])
      stream_for game
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
