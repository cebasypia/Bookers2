class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    current_user.follow(@user)
    redirect_back fallback_location: root_url
  end

  def destroy
    current_user.unfollow(@user)
    redirect_back fallback_location: root_url
  end

  def followings
    @users = @user.followings
    render 'users/index'
  end

  def followers
    @users = @user.followers
    render 'users/index'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
