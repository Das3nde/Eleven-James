class Product < ActiveRecord::Base
  belongs_to :vendor
  has_many :product_images, :dependent => :destroy
  has_many :product_instances, :dependent => :destroy
  accepts_nested_attributes_for :product_images, :reject_if => lambda { |t| t['product_images'].nil? }
  accepts_nested_attributes_for :product_instances

  attr_accessible :brand, :case, :color, :description, :material, :model, :msrp, :price, :is_featured, :is_new, :style, :vendor_id,:face, :tier, :quantity

  def add_inventory
    product_id = sprintf '%05d', id
    product_instance_id = ProductInstance.where('id ~ ?','^'+product_id).count + 1
    instance = ProductInstance.new
    instance.id = "#{product_id}-#{product_instance_id}"
    instance.product_id = id
    storage_record = StorageRecord.create()
    storage_record.record.start_date = Time.now
    storage_record.record.product_instance_id = instance.id
    storage_record.record.table = 'storage_record'
    instance.status_table = 'storage_records'
    instance.storage_record = storage_record
    self.product_instances << instance
    ActiveRecord::Base.transaction do
      self.quantity = self.product_instances.size;
      self.save
      storage_record.record.save
      instance.save
    end
    instance
  end
end
