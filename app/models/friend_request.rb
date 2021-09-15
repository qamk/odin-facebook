class FriendRequest < ApplicationRecord
  belongs_to :sending_user, class_name: 'User'
  belongs_to :receiving_user, class_name: 'User'
end
