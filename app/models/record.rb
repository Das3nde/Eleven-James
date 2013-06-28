class Record < ActiveRecord::Base
  @@record_attrs = [:due_date, :end_date, :start_date, :est_start_date, :est_end_date, :next, :prev, :next_id]
  self.primary_key = :uuid
  attr_accessible *(@@record_attrs)
  attr_accessor :next, :prev, :status
  belongs_to :product_instance
  before_destroy :remove_status

  def remove_status
    switch_status
  end

  def switch_status(new_status_class = nil)
    old_status = self.status.clone
    previous = Record.where('next_id = ?', id).last
    new_status = new_status_class && new_status_class.new({}, {:record => self})
    if(new_status)
      new_status.id = id
      self.status = new_status
    end
    ActiveRecord::Base.transaction do
      if(previous)
        previous.update_attribute('next_table', new_status ? new_status.class.to_s.tableize : nil)
      end

      if(product_instance && product_instance.next_status_id == id)
        product_instance.next_status = new_status
        product_instance.save

      end
      new_status && new_status.save
      old_status.delete
    end
  end

  def dates
    start = start_date.strftime("%m/%d/%Y")
    stop = end_date ? end_date.strftime("%m/%d/%Y") : 'current'
    "#{start} - #{stop}"
  end
  def type
    table.classify.constantize.label
  end

  def status_class
    table.classify.constantize
  end

  def next
    @next ||= next_table && next_table.classify.constantize.find(next_id)
  end
  def next= (status)
    self.next_table = status && status.class.to_s.tableize
    self.next_id = status && status.id
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
    @status ||= status_class.find(id)
  end
  def status=(status)
    status.id = self.id
    self.table = status.class.to_s.tableize
    @status = status
  end
end