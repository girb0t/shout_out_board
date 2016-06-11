class BoardsController < ApplicationController
  def index
    @boards = current_user.boards.order(:created_at)
  end

  def new
  end

  def validate_key
    key = params[:key]
    is_valid = Board.is_unique_key?(key)
    render json: {isValid: is_valid, key: key}
  end

  def create
    form_data = JSON.parse(params["form-data-json"])
    board = Board.new( key: form_data['key']['value'],
                       title: form_data['title']['title'],
                       user_id: session[:user_id])

    (1..form_data["categoryCount"]).each do |i|
      category_hash = form_data["category" + i.to_s]
      category = Category.new(title: category_hash["title"],
                              tab_name: category_hash["tabName"],
                              prompt: category_hash["prompt"])

      board.categories.push(category)
    end

    board.save
    redirect_to "/boards/#{board.key}"
  end

  def update
    Board.find_by(key: params[:key]).update(board_params)
    redirect_to boards_path
  end

  def show
    respond_to do |format|
      format.html {
        @board_key = params["key"]
      }

      format.json do
        if new_posts_available? || params["post_count"].nil?
          render json: Board.find_by(key: params["key"])
                            .to_board_stage_json
        else
          render json: { message: "No new posts!"}
        end
      end
    end
  end


  private

  def board_params
    params.require(:board).permit(:active)
  end

  def new_posts_available?
    if params["post_count"].to_i == Board.find_by(key: params["key"]).posts.count
      false
    else
      true
    end
  end
end
