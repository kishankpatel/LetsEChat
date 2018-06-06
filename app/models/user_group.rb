class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group
  
  scope :get, -> (group_id, user_id) { where(:group_id => group_id, :user_id => user_id).first }
end
