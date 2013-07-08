class Rotation < ActiveRecord::Base
  include Status
  belongs_to :user
  attr_accessible :id, :user, :record

  def self.label
    'Rotation'
  end

  def self.due_date(start = Time.now)
    time = Chronic.parse('11 weeks from now')
    y = time.year
    m = time.month

  end
end
