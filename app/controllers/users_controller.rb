class UsersController < ApplicationController
  def index
    
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end
  
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
    def user_params
      return params.require(:user).permit(:fname, :lname, :email, :password, :password_confirmation)
    end
end
