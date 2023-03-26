class Game < ApplicationRecord
  belongs_to :house
  has_many :players, -> { order(position: :asc) }, dependent: :destroy
  accepts_nested_attributes_for :players, allow_destroy: true, reject_if: :all_blank
  scope :active_games, -> { where(ended: false) }
  after_create_commit { broadcast_prepend_to 'games'}
  after_destroy_commit { broadcast_remove_to 'games'}

end
