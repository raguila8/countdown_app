require "rails_helper"

RSpec.describe "layouts/_header.html.erb" do
  context "logged in" do
    let (:user) { FactoryBot.create(:user) }

    it "should have the right links when signed in" do
      sign_in user
      render
      expect(rendered).to have_selector('.navbar-brand')
      expect(rendered).to have_link('Browse')
      #expect(rendered).to have_selector('.glyphicon-bell')
      expect(rendered).to have_selector('.dropdown .glyphicon-user')
      expect(rendered).to have_selector('.dropdown-toggle span', text: user.username)
      expect(rendered).to have_link('My Countdowns')
      expect(rendered).to have_link('Account')
      expect(rendered).to have_link('Log Out')

      expect(rendered).not_to have_link('Sign Up')
      expect(rendered).not_to have_link('Log In')
    end
  end

  context "not logged in" do
    it "should have the right links" do
      render
      expect(rendered).to have_selector('.navbar-brand')
      expect(rendered).to have_link('Browse')
      #expect(rendered).not_to have_selector('.glyphicon-bell')
      expect(rendered).not_to have_selector('.dropdown .glyphicon-user')
      expect(rendered).not_to have_link('My Countdowns')
      expect(rendered).not_to have_link('Account')
      expect(rendered).not_to have_link('Log Out')

      expect(rendered).to have_link('Sign up')
      expect(rendered).to have_link('Log In')
    end
  end
end
