require 'rails_helper'

describe BoardsController do
  let(:user) { create(:user_with_boards) }
  let(:board) { user.boards.last }

  describe "GET #index" do
    context "user is logged in" do
      before(:each) do
        session[:user_id] = user.id
      end

      it "assigns current user's boards to @boards" do
        get :index
        expect(assigns(:boards)).to match_array user.boards
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "user is not logged in" do
      it "redirects to login_path" do
        get :index
        expect(response).to redirect_to login_path
      end

      it "saves message to flash danger" do
        get :index
        expect(flash[:danger]).to be
      end
    end
  end

  describe "GET #new" do
    context "user is logged in" do
      before(:each) { session[:user_id] = user.id }

      it "renders the new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    context "user is not logged in" do
      it "redirects to login path" do
        get :new
        expect(response).to redirect_to login_path
      end

      it "saves message to flash danger" do
        get :new
        expect(flash[:danger]).to be
      end
    end
  end

  describe "GET #show" do
    context "respond to html" do
      context "board exists" do
        it "assigns @board_key" do
          get :show, key: board.key
          expect(assigns(:board_key)).to eq board.key
        end

        it "renders the show template" do
          get :show, key: board.key
          expect(response).to render_template :show
        end
      end

      context "board does not exist" do
        it "redirects to posts_new_path" do
          get :show, key: 'nonexistent_key'
          expect(response).to redirect_to posts_new_path
        end

        it "saves message to flash danger" do
          get :show, key: 'nonexistent_key'
          expect(flash[:danger]).to be
        end
      end
    end

    context "respond to JSON" do
      before(:each) { request.accept = "application/json" }

      context "is initial page load" do
        it "renders correct Board in JSON" do
          get :show, key: board.key, initial_load: true
          res = JSON.parse(response.body)
          expect(res['key']).to eq board.key
        end
      end

      context "new posts are available" do
        it "renders correct Board in JSON" do
          category = board.categories.create(attributes_for(:category))
          category.posts.create(attributes_for(:post))

          get :show, key: board.key, post_count: 0
          res = JSON.parse(response.body)
          expect(res['key']).to eq board.key
        end
      end

      context "is not initial page load and no new posts" do
        it "returns no posts message in JSON" do
          get :show, key: board.key, post_count: 0
          res = JSON.parse(response.body)
          expect(res['message']).to eq "No new posts!"
        end
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new board in the database"
      it "redirects to the new board's show path"
    end

    context "with invalid params" do
      it "redirects to boards_path"
      it "saves message to flash danger"
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the board board"
      it "redirects to boards path"
    end
    context "with invalid params" do
    end
  end

  describe "GET #validate_key" do
    it "returns invalid key message if key already in DB"
    it "returns valid key message if key not in DB"
  end

end
