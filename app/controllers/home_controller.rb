class HomeController < ApplicationController
  def show
    @boards = Board.active
  end
end
