class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
    @newbook = Book.new
    @user = User.find(current_user.id)
  end

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @user = User.find(current_user.id)
  end

  def new
    @newbook = Book.new
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    @user = User.find(current_user.id)
    if @newbook.save
      redirect_to book_path(@newbook.id), notice: 'You have created book successfully.'
    else
      @books = Book.all
      redirect_to books_path
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
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
end