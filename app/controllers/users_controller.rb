class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = Book.where(user_id: @user.id)
  end
  
  def edit
    
  end
  

end
