class PostsController < ApplicationController
  def new
  end

  def validate_key
    key = params[:key]
    board = Board.where(key: key, active: true).first

    if board
      result = {isActive: true, key: key, categories: board.categories.select('id,prompt,tab_name')}
    else
      result = {isActive: false, key: key}
    end

    render json: result
  end
end
