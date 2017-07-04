class SessionsController < ApplicationController
  def new
    @user
  end
  
  def create
    sub = params[:session]
    user = User.find_by(email: sub[:email].downcase)
    if user && user.authenticate(sub[:password])
      log_in user
      redirect_to user_url(user)
    else
      flash.now[:danger] = "Invalid email or password"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
  
  
end
