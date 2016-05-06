module Schema
  class Error < RuntimeError; end
  class TypeError < Error; end

  def self.included(cls)
    cls.class_exec do
      extend AttributeMacro
    end
  end

  module AttributeMacro
    def attribute_macro(attr_name, interface=nil, strict: nil)
      strict ||= false
      check = nil

      unless interface.nil?
        check = proc do |val|
          if strict
            raise TypeError unless val.instance_of? interface
          else
            raise TypeError unless val.is_a? interface
          end
        end
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
