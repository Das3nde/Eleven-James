class StorageRecord < ActiveRecord::Base
  include Status
  def self.label
    "In Storage"
  end
  attr_accessible :bin_number, :id, :is_available
  attr_accessor :is_available

  def is_available=(is_available)
    @is_available = self.product_instance.is_available = is_available
  end
  def is_available
    @is_available ||= self.product_instance.is_available
  end
end
