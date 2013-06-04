module Temporal


  #implements two table polymorphism
  def self.included(base)
    base.has_one :record, :autosave => true, :foreign_key => :id, :dependent=>:destroy
    base.extend ClassMethods
    base.set_primary_key "uuid"
    base.attr_accessible :start_date, :end_date
    base.define_record_accessors
    base.before_save :generate_uuid
    base.initialize

    def generate_uuid
      if(!self.id)
        self.id = UUID.generate
      end
      if(!self.record)
        self.record = Record.new(:id => self.id)
      end
    end
  end


  def method_missing(meth, *args, &blk)
    if(!record)
      self.record = Record.new(:id => id)
    end
    self.record.send(meth, *args, &blk)
    rescue NoMethodError
    super
  end

  def to_json
    props = Record.new.attributes.keys - Record.protected_attributes.to_a
    retval = self.attributes
    props.each do |p|
      retval[p.to_sym] = self.send(p)
    end
    retval
  end

  module ClassMethods

    def define_record_accessors
      all_attributes = Record.content_columns.map(&:name)
      ignored_attributes = ["created_at", "updated_at", "temporal_type"]
      attributes_to_delegate = all_attributes - ignored_attributes
      attributes_to_delegate.each do |attrib|
        create_attr(name)
      end
    end

    #this part doesn't actually work, but i want it to work so im leaving it in
    def create_attr( name )
      create_method( "#{name}=".to_sym ) { |val|
        instance_variable_set( "@" + name, val)
      }

      create_method( name.to_sym ) {
        instance_variable_get( "@" + name )
      }
    end
    def create_method( name, &block )
      self.class.send( :define_method, name, &block )
    end
  end
end