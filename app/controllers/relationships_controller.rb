class RelationshipsController < ApplicationController
  def follows
    @user  = User.find(params[:id])
    logger.debug(@user.following)
    @users = @user.following
  end

  def followers
     @user  = User.find(params[:id])
     @users = @user.followed
  end

  def follow
    following = User.find(params[:id])
    followed = current_user
    relationship = Relationship.new(following_id:following.id ,followed_id:followed.id)
    if relationship.save
      redirect_to follows_path(current_user)
    else
      render 'index'
    end
  end

  def unfollow
    Relationship.find_by(following_id: params[:id]).destroy
    redirect_to users_path
  end
end