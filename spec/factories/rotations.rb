# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rotation do
    id "e13767f0-94cf-0130-bf6b-38f6b11526e1"
    begin
      if(record = Record.find('e13767f0-94cf-0130-bf6b-38f6b11526e1'))
        record record
      end
    rescue
    end

    user nil
  end
end
