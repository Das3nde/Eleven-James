module Transit
  def self.included(base)

  end

  def self.change_transit record, new_transit
    old_transit = record.status

    ActiveRecord::Base.transaction do
      record.remove_status
      record.status = new_transit
      record.save
    end
  end
end