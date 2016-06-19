require 'rails_helper'

describe UsersController do
  let(:user) { create :user }

  describe "GET #new" do
    context "user is logged in" do
      before(:each) do
        session[:user_id] = user.id
      end

      it "redirects to root_path" do
        get :new
        expect(response).to redirect_to root_path
      end
    end

    context "user is NOT logged in" do
      it "renders the new template" do
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new user in the database" do
        expect {
          post :create, 'form-data-json' => { firstName: 'Luke',
                                              lastName: 'Skywalker',
                                              username: 'yoda42',
                                              password: 'password',
                                              password_confirmation: 'password' }.to_json
        }.to change(User, :count)
      end

      it "saves the user id to the session" do
      end

      it "redirects to boards_new_path" do
      end

      it "saves message to flash success" do
      end
    end

    context "with invalid attributes" do
      it "redirects to signup_path" do
      end

      it "saves message to flash danger" do
      end
    end

  end
end
