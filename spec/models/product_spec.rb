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
  describe "#to_vector" do
    it "properly converts properties to a vector" do
      expected = {"brand-rolex"=>1,
                  "color-blue"=>1,
                  "material-Gold"=>1,
                  "model-navitimer"=>1,
                  "style-luxury"=>1,
                  "case_size"=>1}
      @product.to_vector.should eq(expected)
    end

  end
end
