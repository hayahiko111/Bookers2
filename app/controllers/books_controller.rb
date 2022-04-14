class BooksController < ApplicationController

  before_action :authenticate_user!, only: [:edit, :create, :index, :show, :destroy, :update]
  before_action :correct_user, only: [:edit, :update]

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    @books=Book.all
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user=User.find(current_user.id)
      render:index
    end
  end

  def index
    @books=Book.all
    @book=Book.new
    @user=User.find(current_user.id)
  end

  def show
    @book=Book.find(params[:id])
    @user=@book.user
    @book_new=Book.new
  end

  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def edit
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render:edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end