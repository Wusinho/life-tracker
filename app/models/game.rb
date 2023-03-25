class Game < ApplicationRecord
  belongs_to :house
  has_many :players, dependent: :destroy
  accepts_nested_attributes_for :players, allow_destroy: true, reject_if: :all_blank

  after_create :add_game
  after_create_commit { broadcast_prepend_to 'games'}

end
