class Product < ActiveRecord::Base
  belongs_to :vendor
  has_many :product_images, :dependent => :destroy
  has_many :product_instances, :dependent => :destroy
  accepts_nested_attributes_for :product_images, :reject_if => lambda { |t| t['product_images'].nil? }

  attr_accessible :brand, :case, :color, :description, :material, :model, :msrp, :price, :is_featured, :is_new, :style, :vendor_id,:face, :tier, :quantity
end
