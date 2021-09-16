class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User', inverse_of: :sent_requests
  belongs_to :receiver, class_name: 'User', inverse_of: :received_requests

  validates :sender, uniqueness: { scope: :receiver }
  validate :also_receiver?, on: :create

  def also_receiver?
    FriendRequest.where('sender_id = ? AND receiver_id = ?', receiver, sender).any? &&
      errors.add(:sender, 'You cannot send a friend request to this individual')
  end
end
