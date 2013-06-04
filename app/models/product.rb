class Product < ActiveRecord::Base
  belongs_to :vendor
  has_many :product_images, :dependent => :destroy
  has_many :product_instances, :dependent => :destroy
  accepts_nested_attributes_for :product_images, :reject_if => lambda { |t| t['product_images'].nil? }

  attr_accessible :brand, :case, :color, :description, :material, :model, :msrp, :price, :is_featured, :is_new, :style, :vendor_id,:face, :tier, :quantity

  def self.brand_list
    ['Cartier', 'Rolex', 'Omega', 'Breitling']
  end

  def self.style_list
    ['Sport', 'Luxury']
  end

  def self.tier_list
    ['Artisan', 'tier 2', 'tier 3']
  end

  def self.faces_list
    ['Red', 'Blue', 'Purple', 'Black']
  end

  def self.materials_list
    ['Gold', 'Silver', 'Steel']
  end

end
