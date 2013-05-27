require 'spec_helper'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean


describe Record do
  before(:all) do
    @next_record = FactoryGirl.create(:next_record)
    @prev_record = FactoryGirl.create(:prev_record)
    @storage_record = FactoryGirl.create(:storage_record)
    @rotation_record = FactoryGirl.create(:rotation)
    @record = FactoryGirl.create(:record)

  end
  it "associates next and prev records correctly" do
    @record.next_record().id.should eq(@next_record.id)
    @record.prev_record().id.should eq(@prev_record.id)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
