class BoardsController < ApplicationController
  def new
  end

  def validate_key
    key = params[:key]
    is_valid = Board.is_unique_key?(key)
    render json: {isValid: is_valid, key: key}
  end
end
