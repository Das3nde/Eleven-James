class StorageRecord < ActiveRecord::Base
  include Temporal
  attr_accessible :bin_number, :id, :is_available
end
