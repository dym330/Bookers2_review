class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_book, only: [:edit, :update, :destroy]
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      flash[:alert] = "error #{@book.errors.full_messages}"
      redirect_to books_path
    end
  end
  
  def index
    @user = User.find(current_user.id)
    @new_book = Book.new
    @books = Book.all
  end
  
  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @new_book = Book.new
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      flash[:alert] = "error"
      render "edit"
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def ensure_book
    @book_check = Book.find(params[:id])
    unless @book_check.user.id == current_user.id
      redirect_to books_path
    end
  end
end
