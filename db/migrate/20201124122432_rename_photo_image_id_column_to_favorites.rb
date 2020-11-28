class RenamePhotoImageIdColumnToFavorites < ActiveRecord::Migration[5.2]
  def change
    rename_column :favorites, :photo_image_id, :photo_id
  end
end
