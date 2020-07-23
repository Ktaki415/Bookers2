class BooksController < ApplicationController
  before_action :correct_book, only: [:edit, :update]


  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @books = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def top
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render 'index'
    end
  end

  def about
  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user
  end

  def update
    @books = Book.all
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render 'edit'
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

    def correct_book
    @book = Book.find(params[:id])
    @user = current_user.id
  if @user != @book.user_id
    redirect_to books_path
    flash[:notice] = "error!"
  end
  end

end
