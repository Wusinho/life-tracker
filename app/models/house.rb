class House < ApplicationRecord
  belongs_to :user
  has_many :games, dependent: :destroy

  validates_presence_of :name

  after_create_commit do
    p '*'*100
    p "user_#{self.user_id}"
    p '*'*100
    broadcast_prepend_to "user_#{self.user_id}"
  end
  # after_update_commit{ broadcast_prepend_to "user_#{self.user.id}" }

end
