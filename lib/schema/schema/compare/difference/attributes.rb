module Schema
  module Compare
    class Difference
      class Attributes
        Error = Class.new(RuntimeError)

        Entry = Struct.new(
          :control_attr_name,
          :control_value,
          :compare_attr_name,
          :compare_value
        )

        def entries
          @entries ||= []
        end

        def self.build(attr_names, control_attributes, compare_attributes)
          instance = new

          attr_names.each do |attr_name|
            entry = build_entry(attr_name, control_attributes, compare_attributes)
            instance.entries << entry
          end

          instance
        end

        def self.build_entry(attr_name, control_attributes, compare_attributes)
          control_value = control_attributes[attr_name]
          compare_value = compare_attributes[attr_name]

          entry = Entry.new(
            attr_name,
            control_value,
            attr_name,
            compare_value
          )

          entry
        end

        def difference(attr_name)
          entries.find do |entry|
            entry.control_attr_name == attr_name
          end
        end
        alias :[] :difference

        def add(control_attr_name, control_value, compare_attr_name, compare_value)
          entry = Entry.new(
            control_attr_name,
            control_value,
            compare_attr_name,
            compare_value
          )

          entries << entry

          entry
        end

        def different?(attr_name)
          entry = self[attr_name]

          if entry.nil?
            raise Error, "No attribute difference entry for #{attr_name.inspect}"
          end

          entry.control_value != entry.compare_value
        end
      end
    end
  end
end
