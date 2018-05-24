require 'rails_helper'

RSpec.describe "Sessions controller" do
  let(:user) { FactoryBot.create(:user, name: 'rodrigo',
                                bio: "my bio...") }

  context "signed in" do
    before(:example) do
      sign_in user
    end

    it "should redirect new" do
      get new_user_session_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to match("You are already signed in.")
    end

    it "should redirect create" do
      post user_session_path,
             params: { user: { email: user.email,
                               password: user.password } }
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to match("You are already signed in.")
    end

    it "should logout" do
      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to match("Signed out successfully.")
    end
  end

  context "not signed in" do
    it "should get new" do
      get new_user_session_path
      expect(response).to have_http_status(:success)
      expect(flash[:alert]).to be_nil
    end

    it "should sign in" do
      user
      post user_session_path,
             params: { user: { email: user.email,
                               password: user.password } }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to match("Signed in successfully.")
    end

    it "should redirect destroy" do
      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
    end
  end
end
