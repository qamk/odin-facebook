class FriendRequest < ApplicationRecord
  after_update :update_friendship
  belongs_to :sender, class_name: 'User', inverse_of: :sent_requests
  belongs_to :receiver, class_name: 'User', inverse_of: :received_requests

  validates :sender, uniqueness: { scope: :receiver }
  validate :also_receiver?, on: :create

  scope :for_page, ->(page, num_per_page) {
    order(created_at: :desc).offset(page * num_per_page).limit(num_per_page)
  }

  scope :open_requests, ->(user_id) {
    where('sender_id = :user_id OR receiver_id = :user_id', user_id: user_id)
  }

  scope :sender_only, ->(user_id) {
    where('sender_id = :user_id', user_id: user_id)
  }

  scope :receiver_only, ->(user_id) {
    where('receiver_id = :user_id', user_id: user_id)
  }

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
