require 'spec_helper'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe Product do
  before :all do
    @product = FactoryGirl.create(:product)
    @instance
  end
  describe "#add_inventory" do
    before :all do
      @product.add_inventory
      @instance = @product.product_instances.last
    end
    it "creates a product instance associated with the product" do
      @instance.should_not be_nil
    end
    it "adds a storage_record to the associated product" do
      puts @instance.inspect
      @instance.status.should_not be_nil
      @instance.status.instance_of?(StorageRecord).should be_true
    end
  end
end
