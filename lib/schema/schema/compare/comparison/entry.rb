module Schema
  module Compare
    class Comparison
      Entry = Struct.new(
        :control_attr_name,
        :control_value,
        :compare_attr_name,
        :compare_value
      ) do
        def different?
          control_value != compare_value
        end
      end
    end
  end
end
