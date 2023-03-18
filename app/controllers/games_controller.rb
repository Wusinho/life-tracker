class GamesController < ApplicationController
  # before_action :set_house, only: [:create]
  before_action :set_game, only: [:show, :show, :destroy]

  def index
    @games = Game.all.where(ended: false)
  end

  def show
    @players = @game.players
  end

  def create
    @game = current_user.house.games.build(game_params_for_create)

      if @game.save
        redirect_to game_path @game
      else
        render turbo_stream: error_message(@house)
      end

  end

  def update
    @game = Game.find(params['id'])
  end

  def destroy
    @game.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_game
    @game = Game.find(params['id'])
  end

  def set_house
    @house = House.find(params['id'])
  end

  def game_params_for_create
    params
      .require(:game)
      .permit(
              players_attributes: [:user_id, :game_id, :_destroy]) # permit one-to-many fields
  end

end
