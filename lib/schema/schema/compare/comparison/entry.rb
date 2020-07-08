module Schema
  module Compare
    class Comparison
      Entry = Struct.new(
        :control_attribute_name,
        :control_value,
        :compare_attribute_name,
        :compare_value
      ) do
        def different?
          control_value != compare_value
        end
      end
    end
  end
end
