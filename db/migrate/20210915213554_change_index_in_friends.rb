class ChangeIndexInFriends < ActiveRecord::Migration[6.1]
  def change
    remove_index :friends, :main_user_id
    remove_index :friends, :friend_id
    add_index :friends, %i[main_user_id friend_id], unique: true
  end
end
