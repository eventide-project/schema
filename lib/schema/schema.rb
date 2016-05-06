module Schema
  class Error < RuntimeError; end

  def self.included(cls)
    cls.class_exec do
      extend AttributeMacro
      extend AttributeList
    end
  end

  module AttributeMacro
    def attribute_macro(attr_name, type=nil, strict: nil)
      strict ||= false
      check = nil

      unless type.nil?
        check = proc do |val|
          if strict
            raise Schema::Attribute::TypeError, "#{val} is not an instance of #{type.name}" unless val.instance_of? type
          else
            raise Schema::Attribute::TypeError, "#{val} is not a kind of #{type.name}" unless val.is_a? type
          end
        end
      end

      ::Attribute::Define.(self, attr_name, :accessor, check: check)

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
end
