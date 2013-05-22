class CourierTransit < ActiveRecord::Base
  include Temporal
  attr_accessible :courier, :customer, :id, :is_signature_required, :record

end
