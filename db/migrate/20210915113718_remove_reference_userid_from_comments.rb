class RemoveReferenceUseridFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_reference :comments, :user, foreign_key: true
    add_reference :comments, :commenter, foreign_key: { to_table: :users }
  end
end
