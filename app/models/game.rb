class Game < ApplicationRecord
  belongs_to :house
  has_many :players, -> { order(my_turn: :desc, position: :asc) }, dependent: :delete_all
  has_many :user_kills, dependent: :destroy
  accepts_nested_attributes_for :players, allow_destroy: true, reject_if: :all_blank
  validate :position_uniqueness
  validate :minimum_players

  scope :active_games, -> { where(ended: false) }
  after_create_commit { broadcast_prepend_to 'games'}
  after_update_commit { broadcast_prepend_to 'games'}
  after_destroy_commit { broadcast_remove_to 'games'}

  def game_size
    players.length
  end

  def position_uniqueness
    all_positions = self.players
    sorted_positions = all_positions.map(&:position).sort
    return if sorted_positions ==  (1..all_positions.length).to_a

    errors.add(:players, message: 'Players positions must be unique  ')
  end

  def minimum_players
    total_players = self.players.length
    return if total_players >= 2

    errors.add(:players, message: 'Minimum players 2')
  end

end
