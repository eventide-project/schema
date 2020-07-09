module Schema
  module Compare
    def self.call(control, compare, attribute_names=nil)
      Comparison.build(control, compare, attribute_names)
    end
  end
end
