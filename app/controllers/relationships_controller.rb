class RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def follower
    @user = User.find(params[:id])
  end

  def followed
    @user = User.find(params[:id])
  end
end
