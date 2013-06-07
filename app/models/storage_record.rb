class StorageRecord < ActiveRecord::Base
  include Status
  def self.label
    "In Storage"
  end
  attr_accessible :bin_number, :id, :is_available
end
