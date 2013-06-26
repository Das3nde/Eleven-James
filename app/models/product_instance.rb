class ProductInstance < ActiveRecord::Base
  attr_accessible :current_size, :id, :product, :status, :next_status, :is_available
  belongs_to :product
  #accepts_nested_attributes_for :records
  attr_accessor :status, :next_status

  [:records, :rotations, :services, :storage_records, :courier_transits, :event_transits, :fedex_transits].each do |t|
    has_many t, :autosave => true
  end

  before_create :add_storage_record

  def add_storage_record time = Time.now
    self.status = StorageRecord.new(
        :start_date => Time.now,
        :id => UUID.generate,
        :is_available => true
    )
    self.storage_records << @status
    is_available = true
  end

  def status
    @status ||= status_table.to_class.find(status_id)
  end

  def status=(obj)
    @status = obj
    self.status_id = @status.id
    self.status_table = @status.class.to_s.tableize
  end

  #we store this information on both the status record and here, which is a bit redundant,
  #We're doing so because it needs to be stored on the record and we want to save ourselves a db lookup when sorting
  #product_instances (aka inventory) by transit destination

  def next_status
    @next_status ||= self.next_status_table ? self.next_status_table.to_class.find(next_status_id) : nil
  end

  def next_status=(new_status)
    @next_status = new_status
    self.next_status_table = new_status && new_status.class.table_name
    self.next_status_id = new_status && new_status.id
  end

  def method_missing(meth, *args, &blk)
    product.respond_to?(meth) ? product.send(meth, *args, &blk) : status.send(meth, *args, &blk)
  end

  def history
    Record.where('start_date is not null and product_instance_id = ?', self.id).order('start_date DESC')
  end

  def future
    @future = []
    next_record = next_status && next_status.record
    while(next_record)
      @future << next_record
      next_record = next_record.next_id && Record.find(next_record.next_id)
    end
    return @future.reverse
  end

  def status_name
    label.index('Transit') ? label + ' to ' + next_status_table.classify : label
  end

  def add_rotation(user)
    if(status.class != StorageRecord || is_available != true)
      raise 'Rotations cannot be added to product_instances that are unavailable'
    end
    user.transit_table ||= 'fedex_transits'
    transit_class = user.transit_table.to_class
    rotation = Rotation.new()
    transit = transit_class.new()
    transit.next = rotation

    self.next_status = transit
    status.next = transit
    user.rotations << rotation
    self.rotations << rotation
    self.send(user.transit_table) << transit
    self.is_available = false
    self.save

  end

  def add_service(vendor, transit = FedexTransit.new())
    service = Service.new()
    transit.next = service

    self.next_status = transit
    status.next = transit
    vendor.services << service
    self.services << service
    self.fedex_transits << transit
    self.is_available = false
    self.status.is_available = false
    self.save
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

  def self.available()
    ProductInstance.joins(:storage_records).where("storage_records.is_available is null")
  end

  def remove_future_records()
    Record.where('start_date is null and product_instance_id = ?',id).each do |r|
      r.destroy
    end
  end
end
