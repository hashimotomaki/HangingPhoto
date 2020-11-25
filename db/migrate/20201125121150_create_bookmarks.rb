class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true
      t.references :photo, foreign_key: true

      t.timestamps
      t.index [:user_id, :photo_id], unique: true
    end
  end
end