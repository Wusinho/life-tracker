class GamesController < ApplicationController
  # before_action :set_house, only: [:create]
  before_action :set_game, only: [:show, :show, :destroy]
  before_action :is_invited?, only: [:show]

  def index
    @games = Game.all.where(ended: false)
  end

  def show
    @game_owner = current_user.game_owner?(@game)
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
    redirect_to games_path
  end

  private

  def is_invited?
    return if @players.find_by(user_id: current_user.id)

    error_message('You are not invited')
  end

  def set_game
    @game = Game.find(params['id'])
    @players = @game.players
  rescue
    redirect_to games_path
  end

  def set_house
    @house = House.find(params['id'])
  end

  def game_params_for_create
    params
      .require(:game)
      .permit(
              players_attributes: [:user_id, :game_id, :position, :_destroy])
  end

end
