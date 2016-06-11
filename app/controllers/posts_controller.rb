class PostsController < ApplicationController
  def new
  end

  def create
    new_post = Post.new(category_id: params[:category_id],
                        body: params[:post_body],
                        background_color_hex: params[:bg_color_hex],
                        font_color_hex: params[:font_color_hex],
                        user_id: session[:user_id] )
    new_post.save
    render json: { status: 'ok', categoryId: params[:category_id] }
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
