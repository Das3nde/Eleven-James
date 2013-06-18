# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_request do |p|
    p.user_id    2
    p.product_id 1
    factory :product_request2 do |p|
      p.user_id    2
      p.product_id 2
    end
    factory :product_request3 do |p|
      p.user_id    3
      p.product_id 15
    end
    factory :product_request4 do |p|
      p.user_id    3
      p.product_id 16
    end
  end
end