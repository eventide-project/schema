module Schema
  module Compare
    class Comparison
      include Initializer

      Error = Class.new(RuntimeError)

      initializer :control_class, :compare_class, :entries

      def self.build(control, compare, attr_names=nil)
        control_attributes = control.attributes
        compare_attributes = compare.attributes

        attr_names ||= control_attributes.keys

        entries = attr_names.map do |attr_name|
          build_entry(attr_name, control_attributes, attr_name, compare_attributes)
        end

        new(control.class, compare.class, entries)
      end

      def self.build_entry(control_attr_name, control_attributes, compare_attr_name, compare_attributes)
        control_value = control_attributes[control_attr_name]
        compare_value = compare_attributes[compare_attr_name]

        entry = Entry.new(
          control_attr_name,
          control_value,
          compare_attr_name,
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

      # TODO: attr_name is optional (Nathan Ladd)
      # TODO: optional ignore_class argument (Nathan Ladd)
      def different?(attr_name)
        entry = self[attr_name]

        if entry.nil?
          raise Error, "No attribute difference entry for #{attr_name.inspect}"
        end

        entry.different?
      end
    end
  end
end
