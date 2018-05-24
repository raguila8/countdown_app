require 'rails_helper'

RSpec.describe "Registrations controller" do
  let(:user) { FactoryBot.create(:user, name: 'rodrigo',
                                bio: "my bio...") }
  #let(:other_user) { FactoryBot.create(:other_user, name: 'other user') }

  context "signed in" do
    before(:example) do
      sign_in user
    end

    it "should get edit" do 
      get "/users/edit"
      expect(response).to have_http_status(:success)
      expect(flash[:alert]).to be_nil
    end

    it "should update" do
      put user_registration_path, 
            params: { user: { email: "updated_email@example.com",
                              current_password: user.password } }
      expect(response).to redirect_to user_path(user.id)
      expect(flash[:notice]).to match("Your account has been updated " + 
                                         "successfully")
      user.reload
      expect(user.email).to eq('updated_email@example.com')
    end

    it "should destroy user" do
      delete "/users"
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to be_nil
      expect(flash[:notice]).to match("Bye! Your account has been " + 
                    "successfully cancelled. We hope to see you again soon.")
      expect(User.where(id: user.id)).to be_empty
    end

    it "should redirect new" do
      get new_user_registration_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to match("You are already signed in.")
    end
  
    it "should redirect create" do
      expect(User.count).to eq(1)
      post user_registration_path,
             params: { user: { username: "another_username",
                               email: "another_email@example.com",
                               password: "foobar",
                               password_confirmation: "foobar" } }
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to match("You are already signed in.")
      expect(User.count).to eq(1)
    end
  end

  context "not signed in" do
    it "should get new" do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
      expect(flash[:alert]).to be_nil
    end

    it "should sign up" do
      expect(User.count).to eq(0)
      post user_registration_path,
             params: { user: { username: "another_username",
                               email: "another_email@example.com",
                               password: "foobar",
                               password_confirmation: "foobar" } }
      expect(response).to redirect_to("/countdowns")
      expect(flash[:notice]).to match("Welcome! You have signed up " +
                                        "successfully.")
      expect(User.count).to eq(1)
    end

    it "should redirect edit" do
      get "/users/edit"
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to match("You need to sign in or " +
                                        "sign up before continuing.")
    end

    it "should redirect update" do
      old_email = user.email
      put user_registration_path,
            params: { user: { email: "updated_email@example.com",
                              current_password: user.password } }
      expect(response).to redirect_to new_user_session_path
      expect(flash[:alert]).to match("You need to sign in or " +
                                        "sign up before continuing.")
      user.reload
      expect(user.email).to eq(old_email)
    end

    it "should redirect destroy" do
      user
      delete "/users"
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to match("You need to sign in or " +
                                        "sign up before continuing.")
      expect(User.where(id: user.id)).not_to be_empty
    end
  end
end
