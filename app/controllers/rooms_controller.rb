class RoomsController < ApplicationController
  def search
  end

  def create
    @room = Room.create
    UserRoom.create(:room_id => @room.id, :user_id => current_user.id)
    UserRoom.create(:room_id => @room.id, :user_id => @user.id)
    render 'chats/show'
  end
end
