class Record < ActiveRecord::Base
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

  def self.find(id)
    #if !(id)
    #  puts self.to_yaml
    #end
    generic = super(id)
    if !generic
      return null
    end
    return generic.table.classify.constantize.find(id)
  end
end