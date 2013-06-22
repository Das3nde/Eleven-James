class Service < ActiveRecord::Base
  include Status
  belongs_to :vendor
  attr_accessible :cleaning, :id, :repair_description, :requested_size
  def self.label
    "In Service"
  end
end
