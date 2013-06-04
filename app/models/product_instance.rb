class ProductInstance < ActiveRecord::Base
  attr_accessible :current_size, :status, :status_id
  belongs_to :product
  has_many :records
  accepts_nested_attributes_for :records

  has_many :rotations
  has_many :services
  has_many :storage_records
  has_many :courier_transits
  has_many :event_transits
  has_many :fedex_transits

  belongs_to :record, :foreign_key => :status_id
  belongs_to :rotation, :foreign_key => :status_id
  belongs_to :service, :foreign_key => :status_id
  belongs_to :storage_record, :foreign_key => :status_id
  belongs_to :courier_transit, :foreign_key => :status_id
  belongs_to :event_transit, :foreign_key => :status_id
  belongs_to :fedex_transit, :foreign_key => :status_id

  def record
    self.read_attribute(status_obj)
  end

  def method_missing(meth, *args, &blk)
    if(product.respond_to?(meth))
      product.send(meth, *args, &blk)
    else
      status.send(meth, *args, &blk)
    end
  end


  def history
    history = [] #Record.where('product_id = '+@id)
    Record.where('start_date is not null and product_instance_id = ?', self.id).order('start_date DESC')
  end
  def status
    if(@status)
      return @status
    else
      @status = Record.find(status_id)
    end
    @status
  end

  def status_name
    label = status_table.classify.constantize.label
    if(label.index('Transit'))
      label += ' to ' + next_status_table.classify
    end
    label
  end

  def advance_record(date = Time.now)
    current_record = status()
    next_record = current_record.next_record()
    current.end_date = date;
    next_record.start_date = date
    self.status = next_record;

    ActiveRecord::Base.transaction do
      next_record.save()
      current_record.save()
      self.save()
    end
  end
end
