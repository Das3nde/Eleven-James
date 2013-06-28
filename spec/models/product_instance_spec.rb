require 'spec_helper'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe ProductInstance do
  before :all do
    @instance = ProductInstance.create(
        :id  => "00016-1",
    #:product_id => 16
    )
    @user = FactoryGirl.create(:user)
    @user.transit_table = 'courier_transits'
    @user.save
  end
  describe "#add_storage_record" do
    it "a storage record is added" do
      @instance.storage_records.last.should_not be_nil
    end
    it "a record is added" do
      @instance.records.last.should_not be_nil
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
  describe "#add_rotation" do
    it "doesn't add records to product_instances that aren't available" do
      expect { @instance.add_rotation(@user) }.to raise_error
    end
    it "correctly adds records to product_instances that are available" do
      @instance.is_available = true
      @instance.save

      @instance.add_rotation(@user)

      @instance.reload

      @next_status = @instance.next_status;
      @next_status.class.to_s.should eq('CourierTransit')
      @next_status.id.should eq(@instance.status.next.id)

      @next_status.next.class.to_s.should eq('Rotation')
    end
  end

  describe "#add_services" do
    before :all do
      @vendor = FactoryGirl.create(:vendor)
    end

    it "correctly adds service_records to product_instances" do
      @storage_status = @instance.status
      @storage_status.save

      @instance.add_service(@vendor)
      @next_status = @instance.next_status;
      @next_status.class.to_s.should eq('FedexTransit')
      @next_status.id.should eq(@instance.status.next.id)

      @next_status.next.class.to_s.should eq('Service')
    end
  end

  describe 'record movement' do
    before :all do
      @now = Time.now
      @instance.is_available = true
      @instance.save
      @instance.add_rotation(@user)
      @advancing_status = @instance.next_status
      @instance.advance_record(@now)

    end
    describe "#advance_record" do


      it "sets the next record as the current status" do
        #puts @advancing_instance.status.inspect
        #puts @advancing_status.inspect
        @instance.status.should eq(@advancing_status)
        @instance.next_status.should eq(@advancing_status.next)
      end
    end

    describe '#retreat_record' do
      before :all do
        @retreating_record = @instance.status
        @instance.retreat_record()
      end
      it "sets the previous record as the current status" do
        @instance.status.should eq(@retreating_record.prev)
        @instance.next_status.should eq(@retreating_record)
      end
    end
  end

end
