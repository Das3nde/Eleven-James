# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_instance do
    id  "00016-1"
    product_id 16
    #record_id "e13767f0-94cf-0130-bf6b-38f6b11526e1" #rotation
    current_size "MyString"
    factory :advancing_instance  do
      id  "00016-2"
      product_id 16
      is_available true
      current_size "MyString"
    end
  end
end
