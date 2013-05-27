class Rotation < ActiveRecord::Base
  include Temporal
  belongs_to :user
  attr_accessible :id, :user, :record
end
