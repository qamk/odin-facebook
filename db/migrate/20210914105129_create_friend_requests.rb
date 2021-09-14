class CreateFriendRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_requests do |t|
      t.references :sender, foreign_key: { to_table: :users }
      t.references :receiver, foreign_key: { to_table: :users }
      t.string :message

      t.timestamps
    end
  end
end
