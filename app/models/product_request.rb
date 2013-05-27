class ProductRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  belongs_to :product_instance
  attr_accessible :date, :fulfillment_time, :removal_time
end
