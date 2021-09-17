class FriendRequest < ApplicationRecord
  after_update :update_friendship
  belongs_to :sender, class_name: 'User', inverse_of: :sent_requests
  belongs_to :receiver, class_name: 'User', inverse_of: :received_requests

  validates :sender, uniqueness: { scope: :receiver }
  validate :also_receiver?, on: :create

  private

  def also_receiver?
    FriendRequest.where('sender_id = ? AND receiver_id = ?', receiver, sender).any? &&
      errors.add(:sender, 'You cannot send a friend request to this individual')
  end

  def update_friendship
    friend_details = { main_user: sender, friend: receiver }
    add_friend(friend_details) if accepted
    delete_request
  end

  def delete_request
    self.delete
  end

  def add_friend(details)
    Friend.create(details)
  end
end
