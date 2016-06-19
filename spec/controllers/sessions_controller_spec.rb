require 'rails_helper'

describe SessionsController do
  let(:password) { 'password' }
  let(:user) { build(:user, password: password, password_confirmation: password) }

  describe "GET #new" do
    context "user is logged in" do
      before(:each) do
        user.save!
        session[:user_id] = user.id
      end

      it "redirects to boards_path" do
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
    context "with valid credentials" do
      before(:each) do
        user.save!
        post :create, username: user.username, password: password
      end

      it "saves the user's id to session" do
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to boards_path" do
        expect(response).to redirect_to boards_path
      end

      it "saves message to flash success" do
        expect(flash[:success]).to_not be_nil
      end
    end

    context "with invalid password" do
      before(:each) do
        user.save!
        post :create, username: user.username, password: 'wrong_password'
      end

      it "redirects to login path" do
        expect(response).to redirect_to login_path
      end

      it "saves message to flash danger" do
        expect(flash[:danger]).to_not be_nil
      end
    end

    context "with nonexistent username" do
      before(:each) do
        user.save!
        post :create, username: 'nonexistent_user', password: 'wrong_password'
      end

      it "redirects to login path" do
        expect(response).to redirect_to login_path
      end

      it "saves message to flash danger" do
        expect(flash[:danger]).to_not be_nil
      end
    end
  end

  describe "GET #destroy" do
    before(:each) do
      user.save!
      post :create, username: user.username, password: password
    end

    it "resets the session" do
      expect(session[:user_id]).to eq(user.id)
      get :destroy
      expect(session[:user_id]).to be_nil
    end

    it "redirects to login_path" do
      get :destroy
      expect(response).to redirect_to login_path
    end

    it "saves message to flash success" do
      get :destroy
      expect(flash[:success]).to be
    end
  end

end
