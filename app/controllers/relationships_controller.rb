class RelationshipsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = "フォローしました"
      redirect_back fallback_location: root_url
    else
      # なんでflash.nowか？:alertである必要性も？
      flash.now[:alert] = "フォローに失敗しました"
      redirect_back fallback_location: root_url
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = "フォローを解除しました"
      redirect_back fallback_location: root_url
    else
      flash[:alert] = "フォロー解除に失敗しました"
      redirect_back fallback_location: root_url
    end
  end

  def followings
    @new_book = Book.new
    @user = User.find(params[:user_id])
    @users = @user.followings
    render 'users/index'
  end

  def followers
    @new_book = Book.new
    @user = User.find(params[:user_id])
    @users = @user.followers
    render 'users/index'
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
