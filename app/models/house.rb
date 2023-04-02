class House < ApplicationRecord
  belongs_to :user
  has_many :games, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name
end
