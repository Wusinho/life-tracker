class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:show, :show, :destroy]
  before_action :is_invited?, only: [:show]

  def index
    @games = Game.active_games
  end

  def show
    @game_owner = current_user.game_owner?(@game)
  end

  def create
    @game = current_user.house.games.build(game_params_for_create)
    redirect_to game_path @game if @game.save!

  rescue StandardError => error
    debugger
    rescue_msg(error)
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
    redirect_to root_path if @game.ended
    @players = @game.players
  rescue
  redirect_to root_path
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
