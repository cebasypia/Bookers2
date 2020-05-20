class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i(destroy)

  def create
    book_comment = current_user.book_comments.new(book_comment_params)
    if book_comment.save
      flash[:success] = 'Comment was successfully created.'
      redirect_back fallback_location: root_path
    else
      flash[:danger] = book_comment.errors
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    book_comment = BookComment.find(params[:id])
    book_comment.destroy
    redirect_back fallback_location: root_path
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:content).merge(book_id: params[:book_id])
  end

  def ensure_correct_user
    book_comment = BookComment.find(params[:id])
    return if book_comment.user_id == current_user.id
    flash[:danger] = '権限がありません'
    redirect_back fallback_location: root_path
  end
end
