class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @newbook = Book.new
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @newbook = Book.new
    @books = @user.books.order('created_at DESC')
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
    redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
   else
    render :edit
   end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end