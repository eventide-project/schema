module Schema
  class Error < RuntimeError; end

  def self.included(cls)
    cls.class_exec do
      extend Info
      extend AttributeMacro
      extend Attributes

      include TemplateMethod

      template_method :transform_write do |data|
        transform_out(data)
      end
      template_method :transform_out

      const_set(:Boolean, Boolean)
    end
  end

  module Info
    def type
      name.split('::').last
    end
  end

  module AttributeMacro
    def attribute_macro(attribute_name, type=nil, default: nil)
      type_check = TypeCheck.get(type)

      check = lambda do |val|
        if not type_check.(type, val)
          raise Schema::Attribute::TypeError, "#{val.inspect} of type #{val.class.name} cannot be assigned to #{self.to_s} attribute #{attribute_name.inspect} of type #{type.name}"
        end
      end

      if default.nil?
        initialize_value = nil
      elsif default.respond_to?(:call)
        initialize_value = default
      else
        raise Schema::Attribute::Error, "Default values must be callable, like procs, lambdas, or objects that respond to the call method (Attribute: #{attribute_name})"
      end

      ::Attribute::Define.(self, attribute_name, :accessor, check: check, &initialize_value)

      attribute = attributes.register(attribute_name, type)
      attribute
    end
    alias :attribute :attribute_macro

    module TypeCheck
      def self.call(type, val)
        return true if val.nil?
        return true if type.nil?

        val.is_a?(type)
      end

      def self.get(type)
        return self if type.nil?

        result = Reflect.(type, :TypeCheck, ancestors: true, strict: false)

        if not result.nil?
          return result.constant
        else
          return self
        end
      end
    end
  end

  module Attributes
    def attributes
      @attributes ||= AttributeRegistry.new
    end

    def attribute_names(include_transient: nil)
      include_transient ||= false

      transient_attributes = []
      if respond_to?(:transient_attributes)
        transient_attributes = self.transient_attributes
      end

      attribute_names = []
      attributes.each do |attribute|
        if !include_transient &&
            transient_attributes.include?(attribute.name)
          next
        end

        attribute_names << attribute.name
      end

      attribute_names
    end

    def all_attribute_names
      attribute_names(include_transient: true)
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

    def add(name, type)
      attribute = Schema::Attribute.new(name, type)
      entries << attribute
      attribute
    end

    def register(name, type)
      remove(name)
      add(name, type)
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
    module TypeCheck
      def self.call(type, val)
        return true if val.nil?

        val == true || val == false
      end
    end
  end

  def raw_attributes
    all_attribute_names = self.class.all_attribute_names
    get_attributes(all_attribute_names)
  end

  def get_attributes(attribute_names)
    attribute_names.each_with_object({}) do |attribute_name, attributes|
      attributes[attribute_name] = public_send(attribute_name)
    end
  end

  def attributes(include_transient: nil)
    include_transient ||= false

    attribute_names = self.class.attribute_names(include_transient: include_transient)

    data = get_attributes(attribute_names)

    transform_write(data)

    data
  end

  def to_h
    attributes
  end

  def all_attributes
    attributes(include_transient: true)
  end

  def ==(other, attributes_names=nil, ignore_class: nil)
    ignore_class ||= false

    if not ignore_class
      return false if self.class != other.class
    end

    comparison = Compare.(self, other, attributes_names)

    different = comparison.different?(ignore_class: ignore_class)

    !different
  end
  alias :eql? :==

  def hash
    [self.class, raw_attributes].hash
  end
end
