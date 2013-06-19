# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    id 2
    name 'Test User'
    email 'example2@example.com'
    password 'changeme'
    password_confirmation 'changeme'
    factory :user2 do
      id 3
      name 'Test User'
      email 'example3@example.com'
    end
  end
end
