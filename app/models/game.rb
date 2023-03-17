class Game < ApplicationRecord
  belongs_to :house
  belongs_to :user
  has_many :players
end
