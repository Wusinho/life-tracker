class PlayersChannel < ApplicationCable::Channel
  def subscribed
    if current_user && params[:user_id]
      stream_from "players_channel_#{params[:user_id]}"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
