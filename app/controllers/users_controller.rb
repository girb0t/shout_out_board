class UsersController < ApplicationController
  def new
    redirect_to root_path if logged_in?
    # otherwise render 'new.html.erb'
  end

  def create
    form_data = JSON.parse(params['form-data-json'])
    user_params = JSON.parse(params['form-data-json'])
    user = User.new( first_name: user_params['firstName'],
                     last_name: user_params['lastName'],
                     username: user_params['username'],
                     password: user_params['password'],
                     password_confirmation: user_params['confirmPassword'] )
    if user.save
      flash[:success] = "Successfully created an account. Welcome aboard #{user.first_name}!"
      flash[:success] += " Create your first board below."
      session[:user_id] = user.id
      redirect_to boards_new_path
    else
      flash[:danger] = "Sorry. Something went wrong :'("
      redirect_to '/signup'
    end
  end
end
