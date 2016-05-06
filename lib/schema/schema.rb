module Schema
  class Error < RuntimeError; end
  class TypeError < Error; end

  def self.included(cls)
    cls.class_exec do
      extend AttributeMacro
    end
  end

  module AttributeMacro
    def attribute_macro(attr_name, interface=nil)
      check = nil

      unless interface.nil?
        check = proc { |val| raise TypeError unless val.is_a? interface }
      end

      ::Attribute::Define.(self, attr_name, :accessor, check: check)
    end
    alias :attribute :attribute_macro
  end

  # def attributes
  #   attribute_set.get(self)
  # end

  # def to_h
  #   attributes
  # end
end
