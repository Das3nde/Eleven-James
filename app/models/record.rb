class Record < ActiveRecord::Base
  @@record_attrs = [:due_date, :end_date, :start_date, :est_start_date, :est_end_date, :next, :prev]
  self.primary_key = :uuid
  attr_accessible *(@@record_attrs)
  attr_accessor :next, :prev, :status
  belongs_to :product_instance
  def dates
    start = start_date.strftime("%m/%d/%Y")
    stop = end_date ? end_time.strftime("%m/%d/%Y") : 'current'
    "#{start} - #{stop}"
  end
  def type
    table.classify.constantize.label
  end
  def next
    @next ||= next_table.classify.constantize.find(next_id)
  end
  def next= (status)
    self.next_table = status.class.to_s.tableize
    self.next_id = status.id
    @next = status
    @next.prev = self.status
  end
  def prev
    @prev ||= Record.where('next_id = ?', id).last.status
  end
  def prev=(status)
    @prev = status
  end
  def status
    @status ||= table.classify.constantize.find(id)
  end
end