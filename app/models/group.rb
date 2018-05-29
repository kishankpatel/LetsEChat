class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy

  has_many :group_messages, dependent: :destroy
  has_many :users, through: :user_groups
end
