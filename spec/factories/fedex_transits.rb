# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fedex_transit do
    #id "a6c743f5-982d-4e3f-9ba2-57e769159abd"
    'class' "MyString"
    tracking_number "61292700352544887192"
    is_signature_required false
  end
end
