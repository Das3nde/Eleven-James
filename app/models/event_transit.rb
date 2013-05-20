class EventTransit < ActiveRecord::Base
  belongs_to :event
  attr_accessible :is_pickup
end
