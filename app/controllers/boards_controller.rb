class BoardsController < ApplicationController
  def index
    @boards = Board.active
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
                       title: form_data['title']['title'])

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

  def show
    respond_to do |format|
      format.html {
        @board_key = params["key"]
      }

      format.json do
        render json: Board.find_by(key: params["key"])
                          .to_board_stage_json
      end

    end


  end
end
