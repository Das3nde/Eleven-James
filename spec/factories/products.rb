# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :model do |n|
    "#{n}-model"
  end
end

FactoryGirl.define do
  factory :product do |p|
    p.id    1
    p.model "navitimer"
    p.brand "rolex"
    p.tier nil
    p.material "Gold"
    p.style "luxury"
    p.color "blue"
    p.msrp 1
    p.case_size 45
    p.vendor nil
    p.description "MyText"

  end
  factory :breitling_product, class: Product do |p|
    p.material  "Gold"
    p.style "Breitling"
    p.model { generate(:model) }
  end
  factory :omega_product, class: Product do |p|
    p.material  "Silver"
    p.style "Omega"
    p.model { generate(:model) }
  end


end