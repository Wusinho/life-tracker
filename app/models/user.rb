class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :house
  has_many :games

  def active_game?
    return if self.house.games.empty?
    self.house.games.find_by(ended: false).present?
  end

end
