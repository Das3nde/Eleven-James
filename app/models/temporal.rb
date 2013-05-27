class ActiveRecord::Base
  def self.temporary
    include Temporal
  end
end


module Temporal

  #implements two table polymorphism
  def self.included(base)
    base.has_one :record, :autosave => true, :foreign_key => :id, :dependent=>:destroy
    base.extend ClassMethods

    base.alias_method_chain :record, :autobuild
    base.define_record_accessors
  end

  def record_with_autobuild
    record_without_autobuild || build_record
  end

  def method_missing(meth, *args, &blk)
    record.send(meth, *args, &blk)
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