class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
      t.references :main_user, foreign_key: { to_table: :users }
      t.references :friend, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
