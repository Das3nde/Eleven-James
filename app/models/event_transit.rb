class EventTransit < ActiveRecord::Base
  include Status
  belongs_to :event
  attr_accessible :is_pickup

  def self.label
    'Event Transit'
  end
end
