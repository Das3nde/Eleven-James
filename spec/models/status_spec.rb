require 'spec_helper'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean


describe Record do
  before(:all) do
    @now = Time.now
    @storage_record = StorageRecord.create(
        :start_date => @now
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
end
