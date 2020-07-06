module Schema
  module Controls
    module Schema
      module Different
        def self.attribute_values
          example = Example.new
          example.some_attribute = Controls::Schema.some_attribute
          example.some_other_attribute = some_other_attribute
          example
        end

        def self.some_other_attribute
          'some different value'
        end
      end
    end
  end
end
