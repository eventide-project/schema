module Schema
  class Error < RuntimeError; end

  def self.included(cls)
    cls.class_exec do
      extend AttributeMacro
      extend Attributes

      include Virtual
      virtual :transform_write

      const_set(:Boolean, Boolean)
    end
  end

  module AttributeMacro
    def attribute_macro(attr_name, type=nil, strict: nil, default: nil)
      if type.nil? && !strict.nil?
        raise Schema::Attribute::Error, "The \"#{attr_name}\" attribute is declared with the \"strict\" option but a type is not specified"
      end

      if type == Boolean && strict == false
        raise Schema::Attribute::Error, "The \"#{attr_name}\" attribute is declared with the \"strict\" option disabled but boolean type is specified"
      end

      check = nil

      if type == Boolean
        strict ||= true

        check = proc do |val|
          unless val.nil? || Boolean.(val)
            raise Schema::Attribute::TypeError, "#{val.inspect} is not a boolean"
          end
        end
      elsif !type.nil?
        strict ||= false

        check = proc do |val|
          unless val.nil?
            if strict
              raise Schema::Attribute::TypeError, "#{val.inspect} is not an instance of #{type.name}" unless val.instance_of? type
            else
              raise Schema::Attribute::TypeError, "#{val.inspect} is not a kind of #{type.name}" unless val.is_a? type
            end
          end
        end
      end

      initialize_value = nil
      if default.is_a? Proc
        initialize_value = default
      elsif !default.nil?
        initialize_value = proc { default }
      end

      ::Attribute::Define.(self, attr_name, :accessor, check: check, &initialize_value)

      attribute = attributes.register(attr_name, type, strict)
      attribute
    end
    alias :attribute :attribute_macro
  end

  module Attributes
    def attributes
      @attributes ||= AttributeRegistry.new
    end

    def attribute_names
      transient_attributes = []
      if respond_to?(:transient_attributes)
        transient_attributes = self.transient_attributes
      end

      attribute_names = []
      attributes.each do |attribute|
        next if transient_attributes.include?(attribute.name)
        attribute_names << attribute.name
      end

      attribute_names
    end
  end

  class AttributeRegistry
    def entries
      @entries ||= []
    end

    def length
      entries.length
    end
    alias :count :length

    def [](index)
      entries[index]
    end

    def map(&action)
      entries.map(&action)
    end

    def each(&action)
      entries.each(&action)
    end

    def each_with_object(obj, &action)
      entries.each_with_object(obj, &action)
    end

    def add(name, type, strict=nil)
      strict ||= false
      attribute = Schema::Attribute.new(name, type, strict)
      entries << attribute
      attribute
    end

    def register(name, type, strict=nil)
      remove(name)
      add(name, type, strict)
    end

    def remove(name)
      entries.delete_if { |entry| entry.name == name }
    end

    def attribute(name)
      entries.find { |entry| entry.name == name }
    end

    def attribute?(name)
      !attribute(name).nil?
    end
  end

  module Boolean
    def self.call(val)
      val == true || val == false
    end
  end

  def attributes
    transient_attributes = []
    if self.class.respond_to?(:transient_attributes)
      transient_attributes = self.class.transient_attributes
    end

    data = self.class.attributes.each_with_object({}) do |attribute, attributes|
      next if transient_attributes.include?(attribute.name)
      attributes[attribute.name] = public_send(attribute.name)
    end

    transform_write(data)

    data
  end
  alias :to_h :attributes

## TODO Implement in terms of Compare, Scott Mon Jul 6 2020
  def ==(other, attributes=nil, ignore_class: nil)
    attributes ||= self.class.attribute_names
    attributes = Array(attributes)

    ignore_class = false if ignore_class.nil?

    if !ignore_class
      return false if self.class != other.class
    end

    attributes.each do |attribute|
      if attribute.is_a? Hash
        this_attribute, other_attribute = attribute.keys.first, attribute.values.first
      else
        this_attribute, other_attribute = attribute, attribute
      end

      return false if public_send(this_attribute) != other.public_send(other_attribute)
    end

    true
  end
  alias :eql? :==

  def ===(other)
    self.eql?(other, ignore_class: true)
  end

  def attributes_equal?(other, attributes=nil, print: nil)
    attributes ||= self.class.attribute_names

    print = true if print.nil?
    print ||= false

    equal = self.eql?(other, attributes, ignore_class: true)

    if !equal && print
      attributes = Array(attributes)

      require 'pp'
      puts "self: #{self.class.name}"
      pp self.attributes.select { |k, v| attributes.include? k }
      puts "other #{other.class.name}:"
      pp other.attributes.select { |k, v| attributes.include? k }
      puts "attributes:"
      attributes.each { |a| puts a.inspect}
    end

    equal
  end
end
