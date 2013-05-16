# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transit_fedex do
    id "MyString"
    'class' "MyString"
    tracking_number "MyString"
    is_signature_required false
  end
end
