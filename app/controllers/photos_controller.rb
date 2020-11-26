class PhotosController < ApplicationController
    before_action :authenticate_user!

    def show
      @photo = Photo.find(params[:id])
      @photo_new = Photo.new
      @user = current_user
      @photo_comment = PhotoComment.new
    end

    def index
      @photos = Photo.all.includes(:user).order(created_at: :desc)
      # @like_photos = current_user.bookmark_photos
      @photo = Photo.new
      @user = current_user
      @all_ranks = Photo.create_all_ranks
    end

    def create
      @photo = Photo.new(photo_params.merge(user_id: current_user.id))
      @photo.user_id = current_user.id
       if @photo.save
          redirect_to photo_path(@photo), notice: "You have created book successfully."
       else
          @photos = Photo.all
          @user = current_user
          render 'index'
       end
    end

    def edit
      @photo = Photo.find(params[:id])
      if @photo.user == current_user
          render 'edit'
      else
          redirect_to photos_path
      end
    end

    def update
      @photo = Photo.find(params[:id])
        if @photo.user == current_user
           @photo.update(photo_params)
            redirect_to photos_path, notice: "You have updated book successfully."
        else
          render 'edit'
        end
    end

    def destroy
      @photo = Photo.find(params[:id])
      @photo.destroy
      redirect_to photos_path
    end

    # def bookmarks
    #   @photos = current_user.bookmark_photos.includes(:user)
    # end

    private
    def photo_params
      params.require(:photo).permit(:title, :body, :image)
    end

    def ensure_correct_user
        @photo = Photo.find(params[:id])
        unless @user == current_user
               redirect_to photos_path(current_user)
        end
    end
end
