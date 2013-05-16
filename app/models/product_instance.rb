class ProductInstance < ActiveRecord::Base
  require 'json'
  attr_accessible :current_size, :status, :status_id
  attr_accessor :model, :brand, :tier, :type
  def type
    @type =Product.find(self.id[0,5].to_i)
  end
  def brand
    self.type.brand
  end
  def tier
    self.type.tier
  end
  def model
    self.type.model
  end

  def history
    @history = [] #Record.where('product_id = '+@id)
    records = Record.where('product_id = ?', self.id)
    count = 0
    records.each do |generic|
      @history << generic.table.classify.constantize.find(generic.id);
    end
    return @history
  end
  def status
    if !@status_id
      return nil
    end
    return Record.find(@status_id)
  end
  def next_record
    Record.where('start_date = ?',nil).order('est_start_date ASC').first();
  end
  def advance_record(date = Time.now)
    current_record = status()
    next_record = next_record()
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
