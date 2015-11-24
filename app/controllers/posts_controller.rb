class PostsController < ApplicationController
  def new
  end

  def validate_key
    key = params[:key]
    is_active = Board.is_active_key?(key)
    render json: {isActive: is_active, key: key}
  end
end
