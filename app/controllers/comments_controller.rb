class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i(destroy)

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_back fallback_location: root_path
    else
      flash[:danger] = @comment.errors.full_messages
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(book_id: params[:book_id], user_id: current_user.id)
  end

  def ensure_correct_user
    @comment = Comment.find_by(id: params[:id])
    return if @comment.user_id == current_user.id
    flash[:danger] = '権限がありません'
    redirect_back fallback_location: root_path
  end
end
