require 'spec_helper'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe ProductInstance do
  describe "#add_storage_record" do
    before :all do
      @instance = ProductInstance.create(
          :id  => "00016-1",
          #:product_id => 16
      )
    end
    it "a storage record is added" do
      @instance.storage_records.last.should_not be_nil
      puts @instance.storage_records.last
    end
    it "a record is added" do
      @instance.records.last.should_not be_nil
      puts @instance.records.last
    end

    it "records should reference the product" do
      record = @instance.records.last
      storage_record = @instance.storage_records.last
      record.product_instance.should_not be_nil
      storage_record.product_instance.should_not be_nil
    end

    it "current status of the product_instance should be the storage record" do
      @instance.status.should_not be_nil
      @instance.status.instance_of?(StorageRecord).should be_true
    end
  end
end
