class Event < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :description, :drop_off, :pickup, :state, :subhead, :title, :venue, :zip,
                  :date, :start_time, :end_time, :image
  has_attached_file :image
end
