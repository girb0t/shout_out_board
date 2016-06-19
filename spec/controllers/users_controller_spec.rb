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
        expect(response).to redirect_to boards_path
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
      before(:each) do
        @form_params = {
          username: 'yoda42',
          firstName: 'Luke',
          lastName: 'Skywalker',
          password: 'password',
          password_confirmation: 'password'
        }.to_json
      end

      it "creates a new user in the database" do
        expect {
          post :create, 'form-data-json' => @form_params
        }.to change(User, :count)
      end

      it "saves the user id to the session" do
        post :create, 'form-data-json' => @form_params
        expect(session[:user_id]).to eq(User.last.id)
      end

      it "redirects to boards_new_path" do
        post :create, 'form-data-json' => @form_params
        expect(response).to redirect_to boards_new_path
      end

      it "saves message to flash success" do
        post :create, 'form-data-json' => @form_params
        expect(flash[:success]).to_not be_nil
      end
    end

    context "with invalid attributes" do
      before(:each) do
        @bad_form_params = {
          username: nil,
          firstName: 'Luke',
          lastName: 'Skywalker',
          password: 'password',
          password_confirmation: 'password'
        }.to_json
      end

      it "does not create a new user in the database" do
        expect {
          post :create, 'form-data-json' => @bad_form_params
        }.to_not change(User, :count)
      end

      it "redirects to signup_path" do
        post :create, 'form-data-json' => @bad_form_params
        expect(response).to redirect_to signup_path
      end

      it "saves message to flash danger" do
        post :create, 'form-data-json' => @bad_form_params
        expect(flash[:danger]).to_not be_nil
      end
    end

  end
end
