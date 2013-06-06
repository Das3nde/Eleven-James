module Status
  #implements two table polymorphism. base table is record
  def self.included(base)
    base.has_one :record, :autosave => true, :foreign_key => :uuid, :dependent=>:destroy
    base.belongs_to :product_instance

    base.primary_key =  "uuid"
    base.attr_accessible :start_date, :end_date, :product_instance, :product_instance_id
    attr_accessor :start_date, :end_date
    base.before_create :generate_uuid_and_record
    base.before_save :save_record

    def generate_uuid_and_record
      self.id ||= UUID.generate
      self.record ||= Record.new(:id => self.id)
      record.product_instance_id = product_instance_id
      save_record(true)
    end
    def save_record is_create = false
      if(!self.uuid)
        generate_uuid_and_record
      end
      is_create && record.assign_attributes(:start_date => @start_date, :end_date => @end_date)
      return true
    end
  end
end