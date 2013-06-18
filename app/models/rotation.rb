class Rotation < ActiveRecord::Base
  include Status
  belongs_to :user
  attr_accessible :id, :user, :record

  def self.label
    'Rotation'
  end
end
