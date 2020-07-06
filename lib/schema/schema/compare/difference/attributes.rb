module Schema
  module Compare
    class Difference
      class Attributes
        Entry = Struct.new(
          :attr_name,
          :control_value,
          :compare_value
        )

        def entries
          @entries ||= []
        end

        def self.compare(attr_names, control_values, compare_values)
          # ...
        end

        def self.build(*args)
          compare(*args)
        end

        def difference(attr_name)
          entries.find do |entry|
            entry.attr_name == attr_name
          end
        end
        alias :[] :difference

        def add(attr_name, control_value, compare_value)
          entry = Entry.new(attr_name, control_value, compare_value)
          entries << entry
          entry
        end

        def different?(attr_name)
          entries.any? do |entry|
            entry.attr_name == attr_name
          end
        end
      end
    end
  end
end
