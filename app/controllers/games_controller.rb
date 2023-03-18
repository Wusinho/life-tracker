class GamesController < ApplicationController
  # before_action :set_house, only: [:create]
  before_action :set_game, only: [:show]

  def index
    @games = Game.all.where(ended: false)
  end

  def show
    @player = Player.find_or_create_by(user_id: current_user.id, game_id: @game.id)
    ActionCable.server.broadcast "players_channel_#{@player.user.id}",
                                 {
                                   player: @player.id,
                                   element: ApplicationController.render(partial: 'games/player', locals: { player: @player, user: @player.user}),
                                 }


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
