class AddColumnToFriendRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :friend_requests, :accepted, :boolean, default: nil
  end
end
