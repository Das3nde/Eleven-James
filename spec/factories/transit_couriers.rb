# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transit_courier do
    id "MyString"
    courier "MyString"
    is_signature_required false
    customer "MyString"
  end
end
