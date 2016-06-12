class UsersController < ApplicationController
  def new
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
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:danger] = "Sorry. Something went wrong :'("
      redirect_to '/signup'
    end
  end
end
