module Schema
  def self.included(cls)
    cls.class_exec do
      extend AttributeMacro
    end
  end

    # def self.define(target_class, attr_name, interface=nil)
    #   ::Attribute::Define.(target_class, attr_name, :accessor) do
    #     Substitute.build interface
    #   end
    # end

  module AttributeMacro
    def attribute_macro(attr_name, interface=nil)
      ::Attribute::Define.(self, attr_name, :accessor)
    end
    alias :attribute :attribute_macro
  end


  # include Virtus.module(:constructor => false, :mass_assignment => false)

  # def initialize
  #   set_default_attributes
  # end

  def attributes
    # attribute_set.get(self)
  end

  def to_h
    # attributes
  end
end
