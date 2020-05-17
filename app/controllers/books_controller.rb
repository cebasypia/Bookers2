class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i(edit update destroy)

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
  end

  def index
    @books = Book.all # 一覧表示するためにBookモデルの情報を全てくださいのall
    @new_book = Book.new
  end

  def create
    @book = Book.new(book_params) # Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id

    if @book.save # 入力されたデータをdbに保存する。
      redirect_to @book, notice: "successfully created book!" # 保存された場合の移動先を指定。
    else
      flash.now[:danger] = "error"
      @books = Book.all
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
    else # if文でエラー発生時と正常時のリンク先を枝分かれにしている。
      flash.now[:danger] = "error"
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destoy
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
