module Status
  #implements two table polymorphism. base table is record
  def self.record_attrs
    attrs = Record.accessible_attributes.to_a
    attrs[1, attrs.size]
  end

  def self.included(base)
    @@record_attrs ||= record_attrs
    base.has_one :record, :autosave => true, :foreign_key => :uuid, :dependent=>:destroy
    base.belongs_to :product_instance
    base.primary_key =  "uuid"
    base.attr_accessible *(record_attrs | [:product_instance]) #should be attrs, not sure why it isnt working
    attr_accessor *record_attrs
    base.before_save :associate_record

    def initialize (attributes = {}, options = {})
      super(attributes.slice(@@record_attrs), options)
      self.id = UUID.generate
      self.record = record = Record.new(attributes)
      record.table = self.class.to_s.tableize
      record.id = self.id
      record.status = self
    end

    def associate_record
      record.id = id
      record.product_instance_id = product_instance_id
    end

    @@record_attrs.each do |attr|
      define_method attr.to_s do
        return self.record.send(attr.to_s)
      end
      define_method attr.to_s+'=' do |arg|
        return self.record.send(attr.to_s+'=', arg)
      end
    end
  end
end