class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :house
  has_many :games_created, through: :house, source: :games
  has_many :players
  has_many :user_kills
  validate :active_game?
  has_many :deaths, through: :user_kills, source: :deceased
  has_many :games_played, through: :players, source: :game

  scope :order_wins, -> { order(wins: :desc)}

  def death_players
    deaths.tally.map { |user, count| { nickname: user.nickname, deaths: count } }
          .sort_by { |h| -h[:deaths] }
          .take(2)
  end

  def total_kills
    deaths.length
  end

  def total_games_played
    games_played.length
  end


  def active_game?
    games_created.where(ended: false).count == 0
  end

  def game
    games_created.find_by(ended: false)
  end

  def player
    self.players.find_by(active: true)
  end

  def has_house?
    self.house.present?
  end

  def game_owner?(game)
    return unless has_house?

    self.house.games.where(id: game.id).present?
  end



  def user_killed_most
    return [] if user_kills.empty?

    users = self.user_kills.map { |players| players.deceased }
    user_counts = users.tally

    user_counts.map { |user, count| { nickname: user.nickname, deaths: count } }
               .sort_by { |h| -h[:deaths] }
  end

end
