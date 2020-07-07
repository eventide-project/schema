module Schema
  module Compare
    class Comparison
      include Initializer

      Error = Class.new(RuntimeError)

      Entry = Struct.new(
        :control_attr_name,
        :control_value,
        :compare_attr_name,
        :compare_value
      )

      initializer :entries

      def self.build(control, compare, attr_names=nil)
        control_attributes = control.attributes
        compare_attributes = compare.attributes

        attr_names ||= control_attributes.keys

        entries = attr_names.map do |attr_name|
          build_entry(attr_name, control_attributes, compare_attributes)
        end

        new(entries)
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

      def entry(attr_name)
        entries.find do |entry|
          entry.control_attr_name == attr_name
        end
      end
      alias :[] :entry

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

        #entry.different?
        entry.control_value != entry.compare_value
      end
    end
  end
end
