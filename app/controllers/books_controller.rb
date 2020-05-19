class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i(edit update destroy)

  def show
    @book = Book.find(params[:id])
    @favorite = Favorite.new
    @book_comments = @book.book_comments
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @favorite = Favorite.new
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id

    if @new_book.save
      redirect_to @new_book, notice: "successfully created book!"
    else
      @books = Book.all
      flash.now[:danger] = "error"
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: "successfully updated book!"
    else
      flash.now[:danger] = "error"
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    return if @book.user_id == current_user.id
    redirect_to books_path, notice: '権限がありません'
  end
end
