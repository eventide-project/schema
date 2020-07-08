module Schema
  module Compare
    class Comparison
      Entry = Struct.new(
        :control_name,
        :control_value,
        :compare_name,
        :compare_value
      ) do
        def different?
          control_value != compare_value
        end
      end
    end
  end
end
