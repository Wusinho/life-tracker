class House < ApplicationRecord
  belongs_to :user

  validates_presence_of :name


  after_create_commit{ broadcast_prepend_to 'houses'}
  after_update_commit{ broadcast_prepend_to 'houses'}

end
