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
      self.id = options[:id] || UUID.generate
      self.record = record = options[:record] || Record.new(attributes)
      record.table = self.class.to_s.tableize
      record.id = self.id
      record.status = self
    end

    def associate_record
      record.id = id
      record.product_instance_id = product_instance_id
    end

    def switch (new_status_class, attributes)
      new_status = new_status_class.new(attributes, {:record => record, :id => id})
      if(product_instance.next_status_id == id)
        product_instance.next_status = new_status
      end

      previous = Record.where('next_id = ?', id).last

      ActiveRecord::Base.transaction do
        product_instance.save
        previous.update_attribute('next_table', nil)
        self.destroy()
        new_status.save()
      end
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

  def label
    self.class.label
  end
end