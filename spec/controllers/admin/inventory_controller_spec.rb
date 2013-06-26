require 'spec_helper'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe Admin::InventoryController do
  include Devise::TestHelpers

  before(:all) do
    @now = Time.now
    @storage_record = StorageRecord.create(
        :start_date => @now,
    )
    @transit_record = FactoryGirl.create(:fedex_transit)
    @storage_record.next = @transit_record
    @storage_record.save

    @request = ActionController::TestRequest.new()
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in FactoryGirl.create(:user)
  end
  describe '#change_transit' do
    it 'creates a new transit status' do
      get '/admin/products/'

    end
    it 'removes the old transit status' do

    end

    it 'associates the transit status with the record' do

    end
  end

end