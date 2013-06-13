class Product < ActiveRecord::Base
  belongs_to :vendor
  has_many :product_images, :dependent => :destroy
  has_many :product_instances, :dependent => :destroy
  accepts_nested_attributes_for :product_images, :reject_if => lambda { |t| t['product_images'].nil? }
  accepts_nested_attributes_for :product_instances

  attr_accessible :brand, :case, :color, :description, :material, :model, :msrp, :price, :is_featured, :is_new, :style, :vendor_id,:face, :tier, :quantity

  def add_inventory
    product_id = sprintf '%05d', id
    quantity = ProductInstance.where('id ~ ?','^'+product_id).count + 1

    instance = ProductInstance.create(
        :id => "#{product_id}-#{quantity}",
    )
    product_instances << instance
    quantity = self.product_instances.size
    save()
  end

  def to_vector
    ['brand', 'color', 'material', 'model', 'style', 'face'].each do |attr|
      attr+'-'+self.send(attr).to_s = 1;
    end

  end
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
