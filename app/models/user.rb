class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :house
  has_many :user_games, through: :house, source: :games
  has_one :player

  validate :active_game?

  def active_game?
    user_games.all? { |game| game.ended }
  end

  def has_house?
    self.house.present?
  end

  def game_owner?(game)
    return unless has_house?

    self.house.games.where(id: game.id).present?
  end

end
