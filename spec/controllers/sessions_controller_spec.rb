require 'rails_helper'

describe SessionsController do
  describe "GET #new" do
    context "user is logged in" do
      it "redirects to boards_path"
    end

    context "user is NOT logged in" do
      it "renders the new template"
    end
  end

  describe "POST #create" do
    context "with valid credentials" do
      it "saves the user's id to session"
      it "redirects to boards_path"
      it "saves message to flash success"
    end

    context "with invalid credentials" do
      it "redirects to login path"
      it "saves message to flash danger"
    end
  end

  describe "GET #destroy" do
    it "resets the session"
    it "redirects to login_path"
    it "saves message to flash success"
  end

end
