module Schema
  include Virtus.module(:constructor => false, :mass_assignment => false)

  def attributes
    attribute_set.get(self)
  end
end
