class RenamePhotoImageIdColumnToPhotoComments < ActiveRecord::Migration[5.2]
  def change
        rename_column :photo_comments, :photo_image_id, :photo_id
  end
end
