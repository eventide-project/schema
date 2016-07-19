module Schema
  class Error < RuntimeError; end

  def self.included(cls)
    cls.class_exec do
      extend AttributeMacro
      extend AttributeList
    end
  end

  module AttributeMacro
    def attribute_macro(attr_name, type=nil, strict: nil, default: nil)
      if type.nil? && !strict.nil?
        raise Schema::Attribute::Error, "The \"#{attr_name}\" attribute is declared with the \"strict\" option but a type is not specified"
      end

      strict ||= false
      check = nil

      unless type.nil?
        check = proc do |val|
          unless val.nil?
            if strict
              raise Schema::Attribute::TypeError, "#{val} is not an instance of #{type.name}" unless val.instance_of? type
            else
              raise Schema::Attribute::TypeError, "#{val} is not a kind of #{type.name}" unless val.is_a? type
            end
          end
        end
      end

      initialize_value = nil
      unless default.nil?
        initialize_value = proc { default }
      end

      ::Attribute::Define.(self, attr_name, :accessor, check: check, &initialize_value)

      attribute = attributes.add(attr_name, type, strict)
      attribute
    end
    alias :attribute :attribute_macro
  end

  module AttributeList
    def attributes
      @attributes ||= AttributeRegistry.new
    end

    def attribute_names
      attributes.map { |attribute| attribute.name }
    end
  end

  class AttributeRegistry
    def items
      @items ||= []
    end

    def length
      items.length
    end
    alias :count :length

    def [](index)
      items[index]
    end

    def map(&action)
      items.map(&action)
    end

    def each_with_object(obj, &action)
      items.each_with_object(obj, &action)
    end

    def add(name, type, strict=nil)
      strict ||= false
      attribute = Schema::Attribute.new(name, type, strict)
      items << attribute
      attribute
    end
  end

  def attributes
    self.class.attributes.each_with_object({}) do |attribute, attributes|
      attributes[attribute.name] = public_send(attribute.name)
    end
  end
  alias :to_h :attributes

  def ==(other, attributes=nil, ignore_class: nil)
    attributes ||= self.class.attribute_names
    attributes = Array(attributes)

    ignore_class = false if ignore_class.nil?

    if !ignore_class
      return false if self.class != other.class
    end

    attributes.each do |attribute|
      return false if public_send(attribute) != other.public_send(attribute)
    end

    true
  end
  alias :eql? :==

  def ===(other)
    self.eql?(other, ignore_class: true)
  end

  module Assertions
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
end
