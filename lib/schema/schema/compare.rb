module Schema
  module Compare
    Error = Class.new(RuntimeError)

    def self.call(control, compare, attribute_names=nil)
      if not control.is_a?(Schema)
        raise Error, 'Control object is not an implementation of Schema'
      end

      if not compare.is_a?(Schema)
        raise Error, 'Compare object is not an implementation of Schema'
      end

      Comparison.build(control, compare, attribute_names)
    end
  end
end
