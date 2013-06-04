class Record < ActiveRecord::Base
  set_primary_key :uuid
  include Rails.application.routes.url_helpers
  attr_accessible :bin_number, :due_date, :end_date, :id, :int, :product_instance, :start_date, :table
  belongs_to :temporal, :polymorphic => true, :dependent => :destroy, :autosave => true
  belongs_to :product_instance

  def next_record
    return Record.find(self.next_record_id)
  end

  def prev_record
    return Record.find(self.prev_record_id)
  end

  def dates
    start = start_date.strftime("%m/%d/%Y")
    stop = end_date ? end_time.strftime("%m/%d/%Y") : 'current'
    "#{start - stop}"
  end
=begin
  def self.find(id)
    generic = super(id)
    if !generic
      return null
    end
    return generic.table.classify.constantize.find(id)
  end
=end
end