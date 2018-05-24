require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #landing" do
    it "returns http success" do
      get :landing
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #about" do
    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #attributions" do
    it "returns http success" do
      get :attributions
      expect(response).to have_http_status(:success)
    end
  end

end
