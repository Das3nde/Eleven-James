class ProductInstance < ActiveRecord::Base
  attr_accessible :current_size, :id, :product, :status
  belongs_to :product
  #accepts_nested_attributes_for :records
  attr_accessor :status

  [:records, :rotations, :services, :storage_records, :courier_transits, :event_transits, :fedex_transits].each do |t|
    has_many t, :autosave => true
  end

  before_create :add_storage_record
  before_save :save_status

  def save_status is_create = false
    if(!new_record? || is_create)
      self.status_id = @status.id
      self.status_table = @status.class.to_s.tableize
    end
  end

  def add_storage_record time = Time.now
    @status = StorageRecord.new(
        :start_date => Time.now,
        :id => UUID.generate
    )
    self.storage_records << @status
    save_status(true)
  end

  def status
    puts 'status id id '+status_id
    @status ||= status_table.classify.constantize.find(status_id)
  end

  def status=(obj)
    @status = obj
  end

  def method_missing(meth, *args, &blk)
    product.respond_to?(meth) ? product.send(meth, *args, &blk) : status.send(meth, *args, &blk)
  end

  def history
    Record.where('start_date is not null and product_instance_id = ?', self.id).order('start_date DESC')
  end

  def future
    Record.where('start_date is null and product_instance_id = ?', self.id).order('est_start_date DESC')
  end

  def status_name
    label.index('Transit') ? label + ' to ' + next_status_table.classify : label
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
=begin
  def assign_rotation member, est_start_time
    rotation = Rotation.new(
        :est_start_time
    )
    member.rotations << rotation
    product_instance.rotations << rotation
  end
=end
end
