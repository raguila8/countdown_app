FactoryBot.define do
  factory :user do
    username "raguila8"
    email "raguila8@example.com"
    password "foobar"
  end

  factory :other_user, class: User do
    username "other_user"
    email "other_user@example.com"
    password "foobar"
  end
end
