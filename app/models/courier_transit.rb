class CourierTransit < ActiveRecord::Base
  include Status
  include Transit
  attr_accessible :courier, :customer, :id, :is_signature_required, :record, :courier_id
  def self.label
    'Courier Transit'
  end
end
