class SessionsController < ApplicationController
  def new
    @user
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user != nil && user.authenticate(params[:session][:password])
      log_in user
      remember user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user_url(user)
    else
      flash.now[:danger] = "Invalid email or password"
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
  
end
