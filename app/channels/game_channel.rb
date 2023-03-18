class GameChannel < ApplicationCable::Channel
  def subscribed
    p 'SUBSCRIBED'
    return unless current_user && params[:user_id]

    stream_from "game_channel_#{params[:user_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
