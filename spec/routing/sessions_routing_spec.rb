require 'rails_helper'

RSpec.describe 'session routing', :aggregate_failures, type: :routing do
  it "routes sessions" do
    expect(post: "/users/sign_in").to route_to(
      controller: "sessions", action: "create")

    expect(get: "/users/sign_in").to route_to(
      controller: "sessions", action: "new")

    expect(delete: "/users/sign_out").to route_to(
      controller: "sessions", action: "destroy")
  end
end
