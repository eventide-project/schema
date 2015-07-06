module Schema
  include Virtus.module(:constructor => false, :mass_assignment => false)

  def initialize
    set_default_attributes
  end

  def attributes
    attribute_set.get(self)
  end

  def to_h
    attributes
  end
end
