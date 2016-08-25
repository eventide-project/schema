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

    def register(name, type, strict=nil)
      remove(name)
      add(name, type, strict)
    end

    def remove(name)
      items.delete_if { |entry| entry.name == name }
    end

    def __attribute(name)
      items.find { |entry| entry.name == name }
    end

    def attribute(name)
      items.find { |entry| entry.name == name }
    end

    def attribute?(name)
      !attribute(name).nil?
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
end
