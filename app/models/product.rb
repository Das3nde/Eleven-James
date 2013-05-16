class Product < ActiveRecord::Base
  belongs_to :tier
  belongs_to :vendor
  has_many :trip_images
  accepts_nested_attributes_for :trip_images, :reject_if => lambda { |t| t['trip_image'].nil? }

  attr_accessible :brand, :case, :color, :description, :material, :model, :msrp, :style, :vendor_id, :quantity
end
