module Schema
  include Virtus.module(:constructor => false, :mass_assignment => false)

  def attributes
    attribute_set.get(self)
  end

  def to_h
    attributes
  end
end
