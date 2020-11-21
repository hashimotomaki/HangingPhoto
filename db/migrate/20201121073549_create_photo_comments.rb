class CreatePhotoComments < ActiveRecord::Migration[5.2]
  def change
    create_table :photo_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :photo_image_id

      t.timestamps
    end
  end
end
