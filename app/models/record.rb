class Record < ActiveRecord::Base
  self.primary_key = :uuid
  include Rails.application.routes.url_helpers
  attr_accessible :bin_number, :due_date, :end_date, :start_date, :id, :int, :product_instance, :table
  belongs_to :temporal, :polymorphic => true, :dependent => :destroy, :autosave => true
  belongs_to :product_instance
  def dates
    start = start_date.strftime("%m/%d/%Y")
    stop = end_date ? end_time.strftime("%m/%d/%Y") : 'current'
    "#{start} - #{stop}"
  end
  def type
    table.classify.constantize.label
  end
end