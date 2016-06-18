require 'rails_helper'

describe UsersController do
  let(:user) { create :user }

  describe "GET new" do
    context "user is logged in" do
      before(:each) do
        session[:user_id] = user.id
      end

      it "redirects to root_path" do
        get :new
        expect(response).to redirect_to root_path
      end
    end
  end
end
