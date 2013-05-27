require 'spec_helper'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean


describe Record do
  before(:all) do
    @now = Time.now
    @record = FactoryGirl.create(:record)
    @record.start_time = @now
    @record.save
    @fedex_transit = FactoryGirl.create(:fedex_transit)

  end
  it "the record polymorph has access to record properties" do
    @fedex_transit.start_time.should eq(@record.start_time)
    @fedex_transit.start_time.should eq(@now)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
