class FedexTransit < ActiveRecord::Base
  include Status
  attr_accessible :class_name, :id, :is_signature_required, :tracking_number, :record

  def self.delivery_event tracking_number
    record = self.where("tracking_number = "+tracking_number)

    product = Product.find(record.product_id)
    product.update_status(record.next())

  end
  def self.pickup_event tracking_number
    date = now()
    record = self.where("tracking_number = "+tracking_number)
    prev_record = record.prev()
    record.start_date =
    product = Product.find(record.product_id)
    product.update_status(record)
  end
end
