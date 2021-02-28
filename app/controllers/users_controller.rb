class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_book, only: [:edit, :update, :destroy]
  
  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = Book.where(user_id: @user.id)
  end
  
  def index
    @user = User.find(current_user.id)
    @new_book = Book.new
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "error"
      render "edit"
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def ensure_book
    @user_check = User.find(params[:id])
    unless @user_check.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
