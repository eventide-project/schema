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

        def self.compare(attr_names, control_attributes, compare_attributes)
          instance = new

          attr_names.each do |attr_name|
            entry = compare_attribute(attr_name, control_attributes, compare_attributes)
            instance.entries << entry if not entry.nil?
          end

          instance
        end

        def self.compare_attribute(attr_name, control_attributes, compare_attributes)
          control_value = control_attributes[attr_name]
          compare_value = compare_attributes[attr_name]

          if control_value == compare_value
            return nil
          end

          entry = Entry.new(
            attr_name,
            control_value,
            compare_value
          )

          entry
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
