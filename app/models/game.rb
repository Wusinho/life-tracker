class Game < ApplicationRecord
  belongs_to :house
  has_many :players, dependent: :destroy
end
