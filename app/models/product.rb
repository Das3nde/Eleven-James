class Product < ActiveRecord::Base
  belongs_to :vendor
  has_many :product_images, :dependent => :destroy
  has_many :product_instances, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  accepts_nested_attributes_for :product_images, :reject_if => lambda { |t| t['product_images'].nil? }
  accepts_nested_attributes_for :product_instances

  attr_accessible :brand, :case_size, :color, :description, :material, :model, :msrp, :price, :is_featured, :is_new, :style, :vendor_id,:face, :tier, :quantity

  def add_inventory
    product_id = sprintf '%05d', id
    quantity = ProductInstance.where('id ~ ?','^'+product_id).count + 1

    instance = ProductInstance.create(
        :id => "#{product_id}-#{quantity}",
        :is_available => true
    )
    product_instances << instance
    self.quantity = self.product_instances.size
    save()
    instance
  end

  def to_vector
    vector = {}
    ['brand', 'color', 'material', 'model', 'style', 'face'].each do |attr|
      val = self.send(attr)
      if(val && !val.empty?)
        vector[attr+'-'+val.to_s] = 1;
      end
    end
    vector['case_size'] = relative_case_size()
    return vector
  end

  def relative_case_size
    @@max_case_size ||= Product.maximum('case_size').to_i;
    @@min_case_size ||= Product.minimum('case_size').to_i;
    if @@max_case_size === @@min_case_size
      return 1
    end
    (case_size.to_i - @@min_case_size * 1.0) / (@@max_case_size - @@min_case_size)
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

  def image
    product_images.first.url('thumb')
  end
end
