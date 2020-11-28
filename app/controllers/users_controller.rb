class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @photos = @user.photos
    @photo = Photo.new
    @photo_comment = PhotoComment.new
  end

  def index
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    else
    @users = User.all
    end
    @photo = Photo.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def search
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
      render users_path
    else
      @users = User.none
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
