# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :storage_record do
    id "a52189a0-a6d5-0130-899a-38f6b11526e1"
    begin
      if(record = Record.find('a52189a0-a6d5-0130-899a-38f6b11526e1'))
        record record
      end
    rescue
    end

  end

end
