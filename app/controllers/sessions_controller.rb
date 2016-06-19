class SessionsController < ApplicationController
  def new
    redirect_to boards_path if logged_in?
    # otherwise render 'new.html.erb'
  end

  def create
    #protect against session fixation: http://guides.rubyonrails.org/security.html#session-fixation
    temp_session = session.dup
    reset_session
    session.replace(temp_session)

    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      flash[:success] = "Welcome back #{user.first_name} :)"
      session[:user_id] =  user.id
      redirect_to boards_path
    else
      flash[:danger] = "Username/password incorrect :'("
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    flash[:success] = "Logged out successfully! See you soon."
    redirect_to login_path
  end
end
