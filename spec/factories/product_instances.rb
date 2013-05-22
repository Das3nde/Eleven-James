# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_instances do
    model_id ""
    status "MyString"
    status_id 1
    current_size "MyString"
  end
end
