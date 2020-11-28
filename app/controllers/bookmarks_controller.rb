class BookmarksController < ApplicationController
  def create
    bookmark = current_user.bookmarks.build(photo_id: params[:photo_id])
    bookmark.save!
    redirect_to photos_path, success: t('.flash.bookmark')
  end

  def destroy
    current_user.bookmarks.find_by(photo_id: params[:photo_id]).destroy!
    redirect_to photos_path, success: t('.flash.not_bookmark')
  end
end
