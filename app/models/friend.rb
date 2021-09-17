class Friend < ApplicationRecord
  belongs_to :main_user, class_name: 'User', inverse_of: :friends
  belongs_to :friend, class_name: 'User', inverse_of: :accepted_requests

  validates :main_user, uniqueness: { scope: :friend }
  validate :existing_request?, on: :create

  private

  def existing_request?
    fr_params = { sender: main_user, receiver: friend }
    FriendRequest.where(fr_params).any? || errors.add(:friend, 'Must have received a friend request.')
  end
end
