# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :record do
    id "a6c743f5-982d-4e3f-9ba2-57e769159abd"  #fedex transit record
    product_instance_id "00016-1"
    table "fedex_transits"
    next_record_id "a52189a0-a6d5-0130-899a-38f6b11526e1"
    prev_record_id "e13767f0-94cf-0130-bf6b-38f6b11526e1"
    factory :next_record do
      id  "a52189a0-a6d5-0130-899a-38f6b11526e1"
      table "storage_records"
      product_instance_id "00016-1"
      prev_record_id "e13767f0-94cf-0130-bf6b-38f6b11526e1"
    end
    factory :prev_record do
      id  "e13767f0-94cf-0130-bf6b-38f6b11526e1"
      table "rotations"
      product_instance_id "00016-1"
      next_record_id "a52189a0-a6d5-0130-899a-38f6b11526e1"
    end

  end

end
