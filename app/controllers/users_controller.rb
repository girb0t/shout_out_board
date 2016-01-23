class UsersController < ApplicationController
  def new
  end

  def create
    form_data = JSON.parse(params['form-data-json'])
  end
end
