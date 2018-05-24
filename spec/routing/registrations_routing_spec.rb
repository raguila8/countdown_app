require 'rails_helper'

RSpec.describe 'registration routing', :aggregate_failures, type: :routing do
  it "routes registrations" do
    expect(post: "/users").to route_to(
      controller: "registrations", action: "create")

    expect(get: "/users/sign_up").to route_to(
      controller: "registrations", action: "new")

    expect(get: "/users/edit").to route_to(
      controller: "registrations", action: "edit")

    expect(patch: "/users/").to route_to(
      controller: "registrations", action: "update")

    expect(delete: "/users").to route_to(
      controller: "registrations", action: "destroy")

    expect(get: "/users/cancel").to route_to(
      controller: "registrations", action: "cancel")
  end
end
