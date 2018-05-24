require 'rails_helper'

RSpec.describe 'user routing', :aggregate_failures, type: :routing do
  it "routes users" do
    expect(get: "/users/1").to route_to(
      controller: "users", action: "show", id: "1")

    expect(get: "/users/1/edit").to route_to(
      controller: "users", action: "edit", id: "1")

    expect(put: "/users/1").to route_to(
      controller: "users", action: "update", id: "1")
  end
end
