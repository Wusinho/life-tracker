class PlayersController < ApplicationController
  before_action :set_player, only: [:update]
  def update

  end

  private

  def set_player
    @player = Player.find(params[:id])
  end
end
