module Schema
  module Compare
    def self.call(schema_1, schema_2)
      :foo
    end

    class Difference
      attr_accessor :schema_1
    end
  end
end
