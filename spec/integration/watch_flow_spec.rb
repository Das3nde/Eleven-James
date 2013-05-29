require 'spec_helper'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean


describe "rotation end, watch dropped off;" do
  before(:all) do
    @dropoff_time = Chronic.parse('May 10, 2013 3:08 PM')

    @product_instance = FactoryGirl.create(:product_instance)
    @prev_record = FactoryGirl.create(:prev_record)
    @next_record = FactoryGirl.create(:next_record)
    @storage_record = FactoryGirl.create(:storage_record)
    @prev_rotation = FactoryGirl.create(:rotation)

    record = FactoryGirl.create(:record)
    @fedex_transit = FactoryGirl.create(:fedex_transit)

    #set the status of the product instance to the fedex transit
    @product_instance.record_id = 'a6c743f5-982d-4e3f-9ba2-57e769159abd';
    @product_instance.save()


    puts @product_instance.status().table
    #@member = FactoryGirl.create(:member)
    post 'fedex-email-notifications', :subject => 'FedEx Shipment 61292700352544887192 Delivered', 'body-plain' => IO.read(Rails.root.to_s + '/spec/helpers/fedex_email.html')
  end
  it "creates an in_storage record and sets it as the watch's current status" do
    product_instance = ProductInstance.find(@product_instance.id)
    current_record = product_instance.status()
    current_record.table.should eq('storage_records')
  end
  it "sets the end_time of the transit record and the start_time of the storage record" do
    @fedex_transit.end_time.should eq(@dropoff_time)
    @storage_record.start_time.should eq(@dropoff_time)
  end
=begin
  it "sends member an email letting them know the watch was received" do
    email = ActionMailer::Base.deliveries.pop()
    email.should_not be_empty
    email.subject.should equal('Your last watch has been received')

  end

  it "lets the admin know they need to assign a bin number" do
    pending("not yet implemented")
  end
  it "lets the admin know the watch needs to be cleaned" do
    pending("not yet implemented")
  end
  it "asks the admin if the watch needs servicing" do
    pending("not yet implemented")
  end
  describe "selects a new watch to send to the member" do
    it "creates a new rotation record for the new watch to the member" do
      @new_rotation = RotationRecord.last
      @new_rotation.member_id.should  equal(@member.id)
      @new_rotation.start_time.should be_empty
      @new_rotation.end_time.should be_empty
    end
    it "creates a new transit record for the new watch for shipping to the member" do
      @new_fedex_transit = FedexTransit.last
      @new_fedex_transit.next_record().id.should equal(@new_rotation.id)
      @new_fedex_transit.start_time.should be_empty
      @new_fedex_transit.end_time.should be_empty
    end
    it "prompts the admin to schedule the pickup for the new watch" do
      pending("not yet implemented")
    end
  end
=end

end



describe "admin creates a service record" do
  it "creates a new transit record for shipping to vendor" 
  it "creates a new service record" 
  it "prompts the admin to schedule the pickup" 
end

describe "admin updates service record to completed status" do
  it " prompts the admin to schedule the pickup" 
end

describe "watch gets dropped off from servicing" do
  it "makes the current record the previous one" 
  it "creates an storage record and sets it as the watch's current status" 
  it "lets the admin know they need to assign a bin number" 
  it "marks the watch as available" 
end

describe "admin schedules a pickup" do
  it "properly notifies the transit service" 
  it "adds an est_start_time and est_end_time to the transit record" 
  it "adds an est_start_time and est_end_time to the next record" 
end

describe "watch is picked up from elevenjames" do
  it "sets the current transit record as the previous record" 
  it "sets the next record as the current status" 
  it "sets the start_time on the transit record and the end_time on the storage record" 
end

describe "watch arrives at member's address" do
  it "sets the start_time on the rotation record and the end_time on the transit record"
  it "updates the est_end_time on the rotation record"
  it "creates a transit record from the member's address to elevenjames" 
  it "prompts the admin to schedule the pickup from the member's address" 
end

describe "watch is picked up from member's address" do
  it "sets the end_time on the rotation record and the start_time on the transit record"
  it "updates the est_end_date on the transit record"
end
