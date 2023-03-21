class UserKill < ApplicationRecord
  belongs_to :user
  belongs_to :deceased, foreign_key: :deceased_id, class_name: "User"
end
