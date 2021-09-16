class ChangeIndexInFriendRequests < ActiveRecord::Migration[6.1]
  def change
    remove_index :friend_requests, :receiver_id
    remove_index :friend_requests, :sender_id
    add_index :friend_requests, %i[receiver_id sender_id], unique: true
  end
end
