class RelationshipsController < ApplicationController
  def follows
     @user  = User.find(params[:id])
     @users = @user.followed
  end

  def followers
     @user  = User.find(params[:id])
     @users = @user.followed
  end
end