class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      flash[:success] = "Welcome back #{user.first_name} :)"
      session[:user_id] =  user.id
      redirect_to '/'
    else
      flash[:danger] = "Email/password incorrect :'("
      redirect_to '/login'
    end
  end

  def destroy
    reset_session
    flash[:success] = "Logged out successfully! See you soon."
    redirect_to '/login'
  end
end
