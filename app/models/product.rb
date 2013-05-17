class Product < ActiveRecord::Base
  belongs_to :tier
  belongs_to :vendor
  has_many :product_images
  accepts_nested_attributes_for :product_images, :reject_if => lambda { |t| t['product_images'].nil? }

  attr_accessible :brand, :case, :color, :description, :material, :model, :msrp, :style, :vendor_id, :quantity
end
