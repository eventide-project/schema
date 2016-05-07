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

    def add(name, type, strict=nil)
      strict ||= false
      attribute = Schema::Attribute.new(name, type, strict)
      items << attribute
      attribute
    end
  end

  def attributes
    attributes = {}
    self.class.attributes.map do |attribute|
      attributes[attribute.name] = public_send(attribute.name)
    end
    attributes
  end
  alias :to_h :attributes

  def ==(other)
    self.class == other.class &&
      attributes == other.attributes
  end
end
