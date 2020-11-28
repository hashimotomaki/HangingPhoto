class ResetRelastionshipsTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :relationships, :user_id, :integer
    rename_column :relationships, :follower_id, :following_id
  end
end
