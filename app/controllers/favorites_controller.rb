class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.favorites.create(book_id: params[:book_id])
    redirect_back fallback_location: root_url
  end

  def destroy
    favorite = Favorite.find_by(book_id: params[:book_id], user_id: current_user.id)
    favorite.destroy
    redirect_back fallback_location: root_url
  end

  private

  def favorite_params
    params.require(:favorite).permit(:user_id, :book_id)
  end
end
