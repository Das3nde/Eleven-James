require 'spec_helper'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean


describe Record do
  before(:all) do
    @record = FactoryGirl.create(:record)
    @next_record = FactoryGirl.create(:next_record)
    @prev_record = FactoryGirl.create(:prev_record)
    @storage_record = FactoryGirl.create(:storage_record)
    @rotation_record = FactoryGirl.create(:rotation)
    @current_status = FactoryGirl.create(:fedex_transit)


  end
  it "associates next and prev records correctly" do
    @record.next.id.should eq(@next_record.id)
    @record.prev.id.should eq(@prev_record.id)
  end
  describe "#switch_status" do
    before(:all) do
      @new_record = EventTransit.new({},{:record=>@record})
      @record.switch_status(@new_record)
      @record.save
      @new_record.save
    end
    it 'switches the status' do
      @record.table.should eq('event_transits')
    end

    it 'removes the old status' do
      FedexTransit.where('uuid = ?', @record.id).last.should eq(nil)
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
