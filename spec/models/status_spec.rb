require 'spec_helper'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean


describe Record do
  before(:all) do
    @now = Time.now
    @storage_record = StorageRecord.create(
        :start_date => @now,
    )
    @record = Record.find(@storage_record.id)
  end
  it "storage_record is created" do
    StorageRecord.find(@storage_record.id).should_not be_nil
  end
  it "an record  with the same id created" do
    @record.should_not be_nil
  end
  it "the associated record has a start_date" do
    @record.start_date.should_not be_nil
  end
  describe "next and prev" do
    before :all do
      @next_record = FactoryGirl.create(:fedex_transit)
      @storage_record.next = @next_record
      @storage_record.save
    end
    it "sets and gets the next record" do
      @next_record.id.should eq(@storage_record.next.id)
    end
    it "associates the previous record" do
      @storage_record.id.should eq(@next_record.prev.id)
    end
    it "updates next_id and next_table" do
      @storage_record.record.next_table.should eq('fedex_transits')
      @storage_record.record.next_id.should eq(@next_record.id)
    end
    it "correctly loads the associations from the db" do
      @storage_record.reload()
      @next_record.reload()
      @next_record.id.should eq(@storage_record.next.id)
      @storage_record.id.should eq(@next_record.prev.id)
      @storage_record.record.next_table.should eq('fedex_transits')
      @storage_record.record.next_id.should eq(@next_record.id)
    end
  end
end
