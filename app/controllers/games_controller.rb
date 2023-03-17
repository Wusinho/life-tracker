class GamesController < ApplicationController
  before_action :set_house, only: [:create]
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
    @game = @house.games.build


      if @game.save
        respond_to do |format|
          format.html { redirect_to @game }
        end

      else
        p '*'*100
        p @game.errors.messages

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

end
