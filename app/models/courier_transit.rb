class CourierTransit < ActiveRecord::Base
  include Status
  attr_accessible :courier, :customer, :id, :is_signature_required, :record
  def self.label
    'Courier Transit'
  end
end
