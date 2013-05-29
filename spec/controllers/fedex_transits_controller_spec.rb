require 'spec_helper'
require 'chronic'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

begin
describe Admin::FedexTransitsController do
  before(:all) do
    @c = FedexTransitsController.new()
    @msg_html = IO.read(Rails.root.to_s + '/spec/helpers/fedex_email.html')
    @subject = 'FedEx Shipment 61292700352544887192 Delivered'
    @time = Chronic.parse('May 10, 2013 3:08 PM')

    @product_instance = FactoryGirl.create(:product_instance)
    @prev_record = FactoryGirl.create(:prev_record)
    @next_record = FactoryGirl.create(:next_record)
    @storage_record = FactoryGirl.create(:storage_record)
    @prev_rotation = FactoryGirl.create(:rotation)

    @transit = FactoryGirl.create(:fedex_transit)
    @transit_record = FactoryGirl.create(:record)


    #@transit.record = @transit_record
    #@transit.save()
    #@transit_record.save()

    #@next_record.save()
  end

  it "get_action" do
    @c.get_action(@subject).should eq('delivery')
  end

  it "get_time" do
    @c.get_time(@msg_html).should eq(@time)
  end
  it "get_tracking_number" do
    @c.get_tracking_number(@subject).should eq('61292700352544887192')
  end
  it "pickup" do
    @c.pickup(@transit, @time)
    @transit.start_time.should eq(@time)
    puts @transit.prev_record().to_yaml
    @transit.prev_record().end_time.should eq(@time)
  end
  it "delivery" do
    @c.delivery(@transit, @time)
    @transit.next_record().start_time.should eq(@time)
  end

  it "advance_record" do
    now = Time.now
    @c.advance_record(@transit_record, @next_record, @product_instance, now)
    @transit_record.end_time.should eq(now)
    @next_record.start_time.should eq(now)
    @product_instance.record_id.should eq(@next_record.id)
  end
end
end