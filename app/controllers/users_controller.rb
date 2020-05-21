class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @user = current_user
    @users = User.search("name", params[:str], params[:type])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "successfully updated user!"
      redirect_to user_path(@user)
    else
      flash[:danger] = @user.errors
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :introduction,
      :profile_image,
      :postcode,
      :prefecture_code,
      :address_city,
      :address_street,
      :address_building,
    )
  end

  def ensure_correct_user
    unless params[:id].to_i == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
