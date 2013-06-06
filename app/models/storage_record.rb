class StorageRecord < ActiveRecord::Base
  include Status
  attr_accessor :start_date, :end_date
  def self.label
    "In Storage"
  end
  attr_accessible :bin_number, :id, :is_available
end
