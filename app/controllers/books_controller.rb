class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      @user = current_user
      flash[:notice] = "error"
      render :index
    end
  end

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @show_book = Book.find(params[:id])
    @user = User.find(@show_book.user_id)
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(params[:id])
    else
      flash.now[:notice] = "error"
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    user = current_user
    book = Book.find(params[:id])
    unless user.id == book.user_id
      redirect_to books_path
    end
  end

end
