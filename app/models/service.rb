class Service < ActiveRecord::Base
  include Temporal
  belongs_to :vendor
  attr_accessible :cleaning, :id, :repair_description, :requested_size
end
