class Record < ActiveRecord::Base
  @@record_attrs = [:due_date, :end_date, :start_date, :est_start_date, :est_end_date, :next, :prev]
  self.primary_key = :uuid
  #include Rails.application.routes.url_helpers
  attr_accessible *(@@record_attrs)
  attr_accessor :next, :prev
  #belongs_to :status, :polymorphic => true, :dependent => :destroy, :autosave => true
  belongs_to :product_instance
  #belongs_to :record, :inverse_of => :next
  #has_one :next, :inverse_of => :next
  def dates
    start = start_date.strftime("%m/%d/%Y")
    stop = end_date ? end_time.strftime("%m/%d/%Y") : 'current'
    "#{start} - #{stop}"
  end
  def type
    table.classify.constantize.label
  end
  def next
    puts 'getting next'
    @next ||= next_table.classify.constantize.find(next_id)
  end
  def next= (status)
    puts 'setting next'
    self.next_table = status.class.to_s.tableize
    self.next_id = status.id
    @next = status
    @next.prev = get_status
  end
  def prev
    @prev ||= Record.where('next_id = ?', id).last.get_status
  end
  def prev=(status)
    @prev = status
  end
  def get_status
    table.classify.constantize.find(id)
  end
end