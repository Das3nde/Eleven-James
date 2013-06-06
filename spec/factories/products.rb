# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do |p|
    p.id    1
    p.model "MyString"
    p.brand "MyString"
    p.tier nil
    p.material "MyString"
    p.style "MyString"
    p.color "MyString"
    p.msrp 1
    p.case "MyString"
    p.vendor nil
    p.description "MyText"
  end
end