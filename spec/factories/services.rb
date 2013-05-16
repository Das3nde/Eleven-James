# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    id "MyString"
    requested_size ""
    cleaning ""
    repair_description ""
    vendor nil
  end
end
